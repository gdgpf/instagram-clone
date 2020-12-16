package image

import (
	"api/factory"
	"context"
	"fmt"
	"io/ioutil"
	"net/http"
	"time"

	"cloud.google.com/go/storage"
	"github.com/gorilla/mux"
)

func Url(response http.ResponseWriter, request *http.Request) {
	vars := mux.Vars(request)
	fileCode := vars["fileCode"]

	var exists bool
	var image *Image
	var resp []byte

	if exists, resp, image = index(fileCode); !exists {
		response.WriteHeader(http.StatusNotFound)
		response.Write(resp)
		return
	}

	var fileName string

	ctx := context.Background()
	client, err := storage.NewClient(ctx)

	if err != nil {
		fmt.Println(err)
	}

	ctx, cancel := context.WithTimeout(ctx, time.Second*50)
	defer cancel()

	bucket := client.Bucket("instagram-clone-gdg")

	rc, err := bucket.Object(image.Path).NewReader(ctx)

	defer client.Close()
	slurp, _ := ioutil.ReadAll(rc)

	// attachment, inline
	response.Header().Set("Content-Disposition", "attachment; filename="+fileName)
	response.Header().Set("Content-Type", http.DetectContentType(slurp))
	response.Write(slurp)

	return
}

func index(pathCode string) (bool, []byte, *Image) {
	image := New()
	db := factory.GetConnection()

	{
		rows, err := db.Query(`SELECT * FROM image where path_code = $1 LIMIT 1;`,
			pathCode,
		)
		e, isEr := factory.CheckErr(err)

		if isEr {
			return false, e.ReturnError(), nil
		}

		for rows.Next() {
			err = rows.Scan(
				&image.ID,
				&image.Path,
				&image.Type,
				&image.PathCode,
			)
			e, isEr := factory.CheckErr(err)

			if isEr {
				return false, e.ReturnError(), nil
			}
		}

		if image.ID == 0 {
			return false, factory.ReturnMessage("Nada encontrado"), &image
		}

		return true, nil, &image
	}
}
