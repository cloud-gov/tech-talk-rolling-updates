package main

import (
	"fmt"
	"net/http"
	"os"
	"strconv"
	"time"
)

func main() {

	// template := template.Must(template.ParseFiles("templates/index.html"))

	// http.HandleFunc("/", func(w http.ResponseWriter, r *http.Request) {
	// 	w.Header().Set("Cache-Control", "no-cache, no-store, must-revalidate") // HTTP 1.1.
	// 	w.Header().Set("Pragma", "no-cache")                                   // HTTP 1.0.
	// 	w.Header().Set("Expires", "0")                                         // Proxies.
	// 	if err := template.ExecuteTemplate(w, "index.html", interface{}); err != nil {
	// 		http.Error(w, err.Error(), http.StatusInternalServerError)
	// 	}
	// })

	fs := http.FileServer(http.Dir("./static"))
	http.Handle("/", fs)

	var PORT string
	if PORT = os.Getenv("PORT"); PORT == "" {
		PORT = "8080"
	}

	unhappy := false
	unhappy, _ = strconv.ParseBool(os.Getenv("UNHAPPY"))

	nano := time.Now().UnixNano()
	if unhappy && nano%2 == 0 {
		fmt.Println("I am unhappy. Exiting...")
		os.Exit(1)
	} else {
		fmt.Println("I am happy")
		fmt.Println(http.ListenAndServe(":"+PORT, nil))
	}
}
