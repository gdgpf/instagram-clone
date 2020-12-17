package profile

import (
	"api/factory"
	"encoding/json"
	"net/http"
)

func Index(response http.ResponseWriter, request *http.Request) {
	profile := New()
	var profiles []Profile

	{
		db := factory.GetConnection()
		defer db.Close()

		rows, err := db.Query(`
			SELECT p.*, i.path_code FROM profile p
			INNER JOIN image i on i.id = p.image_id;
		`)
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

			profiles = append(profiles, profile)
		}
	}

	payload, _ := json.Marshal(profiles)
	response.Write(payload)
}
