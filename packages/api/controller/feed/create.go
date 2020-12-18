package feed

import (
	"api/factory"
	"encoding/json"
	"net/http"
)

func Create(response http.ResponseWriter, request *http.Request) {
	feed := New()
	var feedRequest Feed

	defer request.Body.Close()

	{
		if err := json.NewDecoder(request.Body).Decode(&feedRequest); err != nil {
			response.WriteHeader(http.StatusInternalServerError)
			response.Write([]byte("Algo errado com o json, revise!!"))
			return
		}
	}

	{
		db := factory.GetConnection()
		defer db.Close()

		tx, err := db.Begin()
		e, isEr := factory.CheckErr(err)

		if isEr {
			response.WriteHeader(http.StatusInternalServerError)
			response.Write(e.ReturnError())
			return
		}

		{
			stmt, err := tx.Prepare(`INSERT INTO feed (profile_id, image_id, description) VALUES ($1, $2, $3) returning *;`)

			e, isEr := factory.CheckErr(err)

			if isEr {
				tx.Rollback()
				response.WriteHeader(http.StatusInternalServerError)
				response.Write(e.ReturnError())
				return
			}

			err = stmt.QueryRow(feedRequest.Profile.ID, feedRequest.Image.ID, feedRequest.Description).Scan(
				&feed.ID,
				&feed.Profile.ID,
				&feed.Image.ID,
				&feed.CreationDate,
				&feed.Description,
			)
			e, isEr = factory.CheckErr(err)

			if isEr {
				tx.Rollback()
				response.WriteHeader(http.StatusInternalServerError)
				response.Write(e.ReturnError())
				return
			}
		}

		tx.Commit()
	}

	payload, _ := json.Marshal(feed)
	response.Write(payload)
}
