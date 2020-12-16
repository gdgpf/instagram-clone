package profile

type Profile struct {
	ID          int    `json:"id"`
	Username    string `json:"username"`
	Description string `json:"description"`
	ImageID     int    `json:"imageID"`
}

func New() Profile {
	return Profile{}
}
