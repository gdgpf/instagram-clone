package image

import (
	"context"
	"fmt"
	"io"
	"net/http"
	"time"

	"cloud.google.com/go/storage"
	"github.com/gorilla/mux"
)

func Create(response http.ResponseWriter, request *http.Request) {

	vars := mux.Vars(request)
	username := vars["username"]
	typeImage := vars["type"]

	file, handle, err := request.FormFile("file")

	ctx := context.Background()
	client, err := storage.NewClient(ctx)

	if err != nil {
		fmt.Println(err)
	}
	defer file.Close()

	ctx, cancel := context.WithTimeout(ctx, time.Second*50)
	defer cancel()

	bucket := client.Bucket("instagram-clone-gdg")
	wc := bucket.Object(username + "/" + typeImage + "/" + handle.Filename).NewWriter(ctx)
	if _, err = io.Copy(wc, file); err != nil {
		fmt.Println(err)
	}
	if err := wc.Close(); err != nil {
		fmt.Println(err)
	}

	// sakeyFile := "key/storagekey.json"

	// saKey, err := ioutil.ReadFile(sakeyFile)
	// if err != nil {
	// 	log.Fatalln(err)
	// }

	// cfg, err := google.JWTConfigFromJSON(saKey)
	// if err != nil {
	// 	log.Fatalln(err)
	// }

	// url, err := storage.SignedURL("firebase-auth", app+"/"+handle.Filename, &storage.SignedURLOptions{
	// 	GoogleAccessID: cfg.Email,
	// 	PrivateKey:     cfg.PrivateKey,
	// 	Expires:        time.Now().Add(time.Second * 60),
	// 	Method:         "GET",
	// })

	// if err != nil {
	// 	fmt.Println("Error " + err.Error())
	// }

	// response.Header.Set()

	// payload, _ := json.Marshal(Image{
	// 	URL: url,
	// })

	// response.Write(payload)
	return
}
