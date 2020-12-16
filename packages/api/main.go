package main

import (
	"fmt"
	"log"
	"net/http"
	"os"

	"github.com/gorilla/handlers"
	"github.com/joho/godotenv"

	. "api/provider"
)

func main() {
	env := os.Getenv("GO_ENV")
	err := godotenv.Load(".env." + env)
	if err != nil {
		log.Fatal("Não foi possível localizar o arquivo .env")
	}

	port := os.Getenv("PORT")
	if port == "" {
		port = "3000"
		log.Printf("Porta default: %s", port)
	}

	r := Routes()
	log.Printf("Rodando na porta: %s", port)
	fmt.Println(http.ListenAndServe(fmt.Sprintf(":%s", port), handlers.CompressHandler(r)))
}
