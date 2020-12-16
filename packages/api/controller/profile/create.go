package profile

import (
	"api/factory"
	"api/handler"
	"bytes"
	"fmt"
	"io"
	"mime/multipart"
	"net/http"
)

func Create(response http.ResponseWriter, request *http.Request) {
	{
		res, _ := http.Get("https://randomuser.me/api/portraits/men/50.jpg")

		hash := handler.RandomString(30)

		body := &bytes.Buffer{}
		writer := multipart.NewWriter(body)
		part, _ := writer.CreateFormFile("file", hash+".jpg")
		io.Copy(part, res.Body)
		writer.Close()

		fmt.Println(request.Host)

		r, _ := http.NewRequest("POST", "http://"+request.Host+"/booscaaa/image/profile", body)
		r.Header.Add("Content-Type", writer.FormDataContentType())
		client := &http.Client{}
		client.Do(r)
	}

	//
	// {

	// 	// make a sample HTTP GET request

	// 	// check for response error
	// 	if err != nil {
	// 		log.Fatal(err)
	// 	}

	// 	// close response body

	// 	// data, _ := ioutil.ReadAll(res.Body)

	// 	res1, _ := http.Post("http://localhost:8000/booscaaa/image/profile", "multpart/form-data", res.Body)

	// 	fmt.Println(res1)

	// 	res.Body.Close()

	// 	// print all response headers
	// 	fmt.Println(res.Header)

	// 	// get `Content-Type` header
	// 	contentType := res.Header.Get("Content-Type")
	// 	fmt.Println("Content-Type", contentType)

	// }

	{
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

			err = stmt.QueryRow(path, typeImage, hash).Scan(
				&image.ID,
				&image.Path,
				&image.Type,
				&image.PathCode,
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
}
