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
	err := godotenv.Load()
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
