package feed

import (
	"api/factory"
	"encoding/json"
	"net/http"
)

func Index(response http.ResponseWriter, request *http.Request) {
	feed := New()
	var feeds []Feed

	db := factory.GetConnection()
	defer db.Close()

	{
		rows, err := db.Query(`
			SELECT f.id, f.description, f.creation_date, i.id, i.path_code, p.id, p.username FROM feed f
			INNER JOIN image i on i.id = f.image_id
			INNER JOIN profile p on p.id = f.profile_id;
		`)
		e, isEr := factory.CheckErr(err)

		if isEr {
			response.WriteHeader(http.StatusInternalServerError)
			response.Write(e.ReturnError())
			return
		}

		for rows.Next() {
			err = rows.Scan(
				&feed.ID,
				&feed.Description,
				&feed.CreationDate,
				&feed.Image.ID,
				&feed.Image.PathCode,
				&feed.Profile.ID,
				&feed.Profile.Username,
			)
			e, isEr := factory.CheckErr(err)

			if isEr {
				response.WriteHeader(http.StatusInternalServerError)
				response.Write(e.ReturnError())
				return
			}

			{
				rows, err := db.Query(`
					SELECT  i.path_code FROM image i
					INNER JOIN profile p on p.image_id = i.id where p.id = $1;
				`, feed.Profile.ID)
				e, isEr := factory.CheckErr(err)
		
				if isEr {
					response.WriteHeader(http.StatusInternalServerError)
					response.Write(e.ReturnError())
					return
				}
		
				for rows.Next() {
					err = rows.Scan(
						&feed.Profile.PathCode,
					)
					e, isEr := factory.CheckErr(err)
		
					if isEr {
						response.WriteHeader(http.StatusInternalServerError)
						response.Write(e.ReturnError())
						return
					}

				}
			}

			feeds = append(feeds, feed)
		}
	}

	

	payload, _ := json.Marshal(feeds)
	response.Write(payload)
}
