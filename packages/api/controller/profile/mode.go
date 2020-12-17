package profile

type Profile struct {
	ID          int    `json:"id,omitempty"`
	Username    string `json:"username,omitempty"`
	Description string `json:"description,omitempty"`
	ImageID     int    `json:"imageID,omitempty"`
	PathCode    string `json:"pathCode,omitempty"`
}

func New() Profile {
	return Profile{}
}
