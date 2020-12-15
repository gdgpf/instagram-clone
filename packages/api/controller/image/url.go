package image

import (
	"encoding/json"
	"fmt"
	"io/ioutil"
	"log"
	"net/http"
	"os"
	"time"

	"cloud.google.com/go/storage"
	"github.com/gorilla/mux"
	"golang.org/x/oauth2/google"
)

func Url(response http.ResponseWriter, request *http.Request) {
	vars := mux.Vars(request)
	username := vars["username"]
	typeImage := vars["type"]
	fileName := vars["file"]

	key, err := ioutil.ReadFile(os.Getenv("GOOGLE_APPLICATION_CREDENTIALS"))
	if err != nil {
		log.Fatalln(err)
	}

	cfg, err := google.JWTConfigFromJSON(key)
	if err != nil {
		log.Fatalln(err)
	}

	url, err := storage.SignedURL("instagram-clone-gdg", username+"/"+typeImage+"/"+fileName, &storage.SignedURLOptions{
		GoogleAccessID: cfg.Email,
		PrivateKey:     cfg.PrivateKey,
		Expires:        time.Now().Add(time.Second * 60),
		Method:         "GET",
	})

	if err != nil {
		fmt.Println("Error " + err.Error())
	}

	payload, err := json.Marshal(Image{
		URL: url,
	})

	if err != nil {
		response.WriteHeader(http.StatusNotFound)
		response.Write([]byte("Nenhuma imagem encontrada!!"))
		return
	}

	response.Write(payload)
}
