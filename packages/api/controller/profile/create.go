package profile

import (
	"api/controller/image"
	"api/factory"
	"api/handler"
	"bytes"
	"encoding/json"
	"io"
	"math/rand"
	"mime/multipart"
	"net/http"
	"strconv"
)

const (
	MASCULINO = "men"
	FEMININO  = "women"
)

func Create(response http.ResponseWriter, request *http.Request) {
	profile := New()
	image := image.New()
	var profileRequest Profile

	defer request.Body.Close()

	{
		if err := json.NewDecoder(request.Body).Decode(&profileRequest); err != nil {
			response.WriteHeader(http.StatusInternalServerError)
			response.Write([]byte("Algo errado com o json, revise!!"))
			return
		}
	}

	{
		numero := rand.Intn(99)
		numeroGenero := rand.Intn(1)
		foto := strconv.Itoa(numero)
		var res *http.Response

		switch numeroGenero {
		case 0:
			res, _ = http.Get("https://randomuser.me/api/portraits/" + FEMININO + "/" + foto + ".jpg")
			break
		case 1:
			res, _ = http.Get("https://randomuser.me/api/portraits/" + MASCULINO + "/" + foto + ".jpg")
		}

		hash := handler.RandomString(90)

		body := &bytes.Buffer{}
		writer := multipart.NewWriter(body)
		part, _ := writer.CreateFormFile("file", hash+".jpg")
		io.Copy(part, res.Body)
		writer.Close()

		r, _ := http.NewRequest("POST", "http://"+request.Host+"/booscaaa/image/profile", body)
		r.Header.Add("Content-Type", writer.FormDataContentType())
		client := &http.Client{}
		resp, _ := client.Do(r)

		if err := json.NewDecoder(resp.Body).Decode(&image); err != nil {
			response.WriteHeader(http.StatusInternalServerError)
			response.Write([]byte("Problemas com a criação da imagem!!"))
			return
		}
	}

	{
		db := factory.GetConnection()
		defer db.Close()

		tx, err := db.Begin()
		e, isEr := factory.CheckErr(err)

		if isEr {
			response.WriteHeader(http.StatusInternalServerError)
			response.Write(e.ReturnError())
			return
		}

		{
			stmt, err := tx.Prepare(`INSERT INTO profile (username, description, image_id) VALUES ($1, $2, $3) returning *;`)

			e, isEr := factory.CheckErr(err)

			if isEr {
				tx.Rollback()
				response.WriteHeader(http.StatusInternalServerError)
				response.Write(e.ReturnError())
				return
			}

			err = stmt.QueryRow(profileRequest.Username, profileRequest.Description, image.ID).Scan(
				&profile.ID,
				&profile.Username,
				&profile.Description,
				&profile.ImageID,
			)
			e, isEr = factory.CheckErr(err)

			if isEr {
				tx.Rollback()
				response.WriteHeader(http.StatusInternalServerError)
				response.Write(e.ReturnError())
				return
			}
		}

		tx.Commit()
	}

	payload, _ := json.Marshal(profile)
	response.Write(payload)
}
