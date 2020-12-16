package image

type Image struct {
	ID       int    `json:"id"`
	Path     string `json:"path"`
	Type     string `json:"type"`
	PathCode string `json:"pathCode"`
}

func New() Image {
	return Image{}
}
