package main

import (
//	"bytes"
//	"io/ioutil"
	"log"
	"net/http"
//	"time"
//	"fmt"
//	"strings"
)

func main() {
	log.Fatal(http.ListenAndServe(":7070", http.HandlerFunc(func(rw http.ResponseWriter, r *http.Request) {
		/*data, err := ioutil.ReadFile("/root/"+r.URL.Path[1:])
		if err != nil {
			log.Fatal(err)
		}
		http.ServeContent(rw, r, "/root/myfile", time.Now(), bytes.NewReader(data))
		*/
		http.ServeFile(rw, r, "/root/"+r.URL.Path[1:])
	})))
}
