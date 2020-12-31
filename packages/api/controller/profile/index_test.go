package profile

import (
	"log"
	"net/http"
	"net/http/httptest"
	"testing"

	"github.com/gorilla/mux"
	"github.com/joho/godotenv"
	"github.com/steinfletcher/apitest"
)

func init() {
	err := godotenv.Load("../../.env.development")
	if err != nil {
		log.Fatal("Não foi possível localizar o arquivo .env")
	}
}

func TestApiLib(t *testing.T) {
	apitest.New().
		// Report(apitest.SequenceDiagram()).
		Handler(http.HandlerFunc(Index)).
		Get("/profile").
		Expect(t).
		Status(http.StatusOK).
		End()
}

func TestWhitoutLib(t *testing.T) {
	r := mux.NewRouter()
	r.HandleFunc("/profile", Index)
	ts := httptest.NewServer(r)
	defer ts.Close()
	t.Run("Deve retornar 200", func(t *testing.T) {
		res, err := http.Get(ts.URL + "/profile")
		if err != nil {
			t.Errorf("Expected nil, received %s", err.Error())
		}
		if res.StatusCode != http.StatusOK {
			t.Errorf("Expected %d, received %d", http.StatusNotFound, res.StatusCode)
		}
	})
}
