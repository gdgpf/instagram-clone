package image

import (
	"api/factory"
	"api/handler"
	"context"
	"encoding/json"
	"io"
	"net/http"
	"path/filepath"
	"time"

	"cloud.google.com/go/storage"
	"github.com/gorilla/mux"
)

func Create(response http.ResponseWriter, request *http.Request) {
	vars := mux.Vars(request)
	username := vars["username"]
	typeImage := vars["type"]

	file, handle, err := request.FormFile("file")
	defer file.Close()

	extention := filepath.Ext(handle.Filename)
	hash := handler.RandomString(90)

	path := username + "/" + typeImage + "/" + string(hash) + extention

	var created bool
	var image *Image
	var resp []byte

	if created, resp, image = create(path, typeImage, hash); !created {
		response.WriteHeader(http.StatusInternalServerError)
		response.Write(resp)
		return
	}
	ctx := context.Background()
	client, err := storage.NewClient(ctx)

	if err != nil {
		image.delete()
	}

	ctx, cancel := context.WithTimeout(ctx, time.Second*50)
	defer cancel()

	bucket := client.Bucket("instagram-clone-gdg")
	wc := bucket.Object(path).NewWriter(ctx)
	if _, err = io.Copy(wc, file); err != nil {
		image.delete()
	}
	if err := wc.Close(); err != nil {
		image.delete()
	}

	payload, _ := json.Marshal(image)
	response.Write(payload)
}

func create(path string, typeImage string, hash string) (bool, []byte, *Image) {
	image := New()
	db := factory.GetConnection()
	defer db.Close()

	{

		tx, err := db.Begin()
		e, isEr := factory.CheckErr(err)

		if isEr {
			return false, e.ReturnError(), nil
		}

		{
			stmt, err := tx.Prepare(`INSERT INTO image (path, type, path_code) VALUES ($1, $2, $3) returning *;`)

			e, isEr := factory.CheckErr(err)

			if isEr {
				tx.Rollback()
				return false, e.ReturnError(), nil
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
				return false, e.ReturnError(), nil
			}
		}

		tx.Commit()
	}
	return true, nil, &image
}

func (image Image) delete() {
	db := factory.GetConnection()
	defer db.Close()

	{

		tx, err := db.Begin()
		_, isEr := factory.CheckErr(err)

		if isEr {
			tx.Rollback()
		}

		{
			stmt, err := tx.Prepare(` 	DELETE * FROM image WHERE id = $1; `)

			_, isEr := factory.CheckErr(err)

			if isEr {
				tx.Rollback()
			}

			_, err = stmt.Exec(image.ID)
			_, isEr = factory.CheckErr(err)

			if isEr {
				tx.Rollback()
			}
		}

		tx.Commit()
	}
}
