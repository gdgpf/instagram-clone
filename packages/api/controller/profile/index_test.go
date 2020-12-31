package profile

import (
	"log"
	"net/http"
	"testing"

	"github.com/joho/godotenv"
	"github.com/steinfletcher/apitest"
)

var getUser = apitest.NewMock().
	Get("/user/12345").
	RespondWith().
	Body(`{"name": "jon", "id": "1234"}`).
	Status(http.StatusOK).
	End()

var getPreferences = apitest.NewMock().
	Get("/preferences/12345").
	RespondWith().
	Body(`{"is_contactable": true}`).
	Status(http.StatusOK).
	End()

func TestApi(t *testing.T) {
	err := godotenv.Load("../../.env.development")
	if err != nil {
		log.Fatal("Não foi possível localizar o arquivo .env")
	}

	apitest.New().
		Handler(http.HandlerFunc(Create)).
		Post("/aaaa").
		Body(`{"username": "vnnb", "description": "aaaaaaaa"}`).
		Expect(t).
		Status(http.StatusOK).
		End()
}
