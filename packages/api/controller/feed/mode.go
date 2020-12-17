package feed

type Feed struct {
	ID           int     `json:"id,omitempty"`
	Profile      Profile `json:"profile,omitempty"`
	Image        Image   `json:"image,omitempty"`
	Description  string  `json:"description,omitempty"`
	CreationDate string  `json:"creationDate,omitempty"`
}

type Profile struct {
	ID       int    `json:"id,omitempty"`
	Username string `json:"username,omitempty"`
}

type Image struct {
	ID       int    `json:"id,omitempty"`
	PathCode string `json:"pathCode,omitempty"`
}

func New() Feed {
	return Feed{}
}
