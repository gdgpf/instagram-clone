package provider

import (
	"api/controller/image"
	"api/controller/profile"
	"net/http"

	"github.com/gorilla/mux"
)

//auth is a local function to control the session in middleware
func auth(next http.Handler) http.Handler {
	return http.HandlerFunc(func(response http.ResponseWriter, request *http.Request) {
		response.Header().Set("Access-Control-Allow-Methods", "POST, OPTIONS, DELETE, PUT")
		response.Header().Set("Content-Type", "application/json")
		response.Header().Set("Access-Control-Allow-Origin", "*")
		response.Header().Set("Access-Control-Allow-Headers", "Content-Type, Authorization")

		next.ServeHTTP(response, request)
	})
}

func Routes() *mux.Router {
	r := mux.NewRouter()

	r.Handle("/{username}/image/{type}", auth(http.HandlerFunc(image.Create))).Methods("POST", "OPTIONS")
	r.Handle("/image/{fileCode}", auth(http.HandlerFunc(image.Url))).Methods("GET", "OPTIONS")

	r.Handle("/profile", auth(http.HandlerFunc(profile.Create))).Methods("POST", "OPTIONS")

	return r
}
