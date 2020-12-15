package provider

import (
	"api/controller/image"
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
		// if request.Method == "OPTIONS" {
		// 	response.WriteHeader(http.StatusOK)
		// } else {
		// 	bearToken := request.Header.Get("Authorization") // bear token must be 2 params -- Bearer <token>
		// 	if isAuth, access := middleware.VerifyToken(bearToken); isAuth {
		// 		request = middleware.SetContextData(request, &access)
		next.ServeHTTP(response, request)
		// } else {
		// 	response.WriteHeader(http.StatusUnauthorized)
		// 	response.Write(handler.ReturnMessage("Acesso negado"))
		// }
		// }
	})
}

func Routes() *mux.Router {
	r := mux.NewRouter()

	r.Handle("/{username}/image/{type}", auth(http.HandlerFunc(image.Create))).Methods("POST", "OPTIONS")
	r.Handle("/{username}/image/{type}/{file}", auth(http.HandlerFunc(image.Url))).Methods("GET", "OPTIONS")

	return r
}
