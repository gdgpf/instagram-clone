package profile

import (
	"api/factory"
	"encoding/json"
	"net/http"

	"github.com/gorilla/mux"
)

func SingleIndex(response http.ResponseWriter, request *http.Request) {
	profile := New()

	vars := mux.Vars(request)
	username := vars["username"]

	{
		db := factory.GetConnection()
		defer db.Close()

		rows, err := db.Query(`
			SELECT p.*, i.path_code FROM profile p
			INNER JOIN image i on i.id = p.image_id WHERE p.username = $1;
		`, username)
		e, isEr := factory.CheckErr(err)

		if isEr {
			response.WriteHeader(http.StatusInternalServerError)
			response.Write(e.ReturnError())
			return
		}

		for rows.Next() {
			err = rows.Scan(
				&profile.ID,
				&profile.Username,
				&profile.Description,
				&profile.ImageID,
				&profile.PathCode,
			)
			e, isEr := factory.CheckErr(err)

			if isEr {
				response.WriteHeader(http.StatusInternalServerError)
				response.Write(e.ReturnError())
				return
			}

		}
	}

	payload, _ := json.Marshal(profile)
	response.Write(payload)
}
