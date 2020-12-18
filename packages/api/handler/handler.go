package handler

import (
	"os"
	"strings"

	"golang.org/x/crypto/bcrypt"
)

const letterBytes = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"

func RandomString(n int) string {
	// b := make([]byte, n)
	// for i := range b {
	// 	b[i] = letterBytes[rand.Intn(len(letterBytes))]
	// }
	// return string(b)

	hashedPassword, _ := bcrypt.GenerateFromPassword([]byte(os.Getenv("IMAGE_HASH")), bcrypt.DefaultCost)

	str := strings.Replace(string(hashedPassword), "/", "", n)

	return str
}
