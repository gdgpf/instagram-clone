package provider

import (
	"api/controller/feed"
	"api/controller/image"
	"api/controller/profile"
	"net/http"

	"github.com/gorilla/mux"
)

//auth is a local function to control the session in middleware
func cors(next http.Handler) http.Handler {
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

	r.Handle("/{username}/image/{type}", cors(http.HandlerFunc(image.Create))).Methods("POST", "OPTIONS")
	r.Handle("/image/{fileCode}", cors(http.HandlerFunc(image.Url))).Methods("GET", "OPTIONS")

	r.Handle("/profile", cors(http.HandlerFunc(profile.Create))).Methods("POST", "OPTIONS")
	r.Handle("/profile", cors(http.HandlerFunc(profile.Index))).Methods("GET", "OPTIONS")
	r.Handle("/profile/{username}", cors(http.HandlerFunc(profile.SingleIndex))).Methods("GET", "OPTIONS")

	r.Handle("/feed", cors(http.HandlerFunc(feed.Create))).Methods("POST", "OPTIONS")
	r.Handle("/feed", cors(http.HandlerFunc(feed.Index))).Methods("GET", "OPTIONS")

	return r
}
