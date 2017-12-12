package main

import (
    "bufio"
    "fmt"
    // "io"
    // "io/ioutil"
    "log"
    "os"
)

func check(e error) {
    if e != nil {
        panic(e)
    }
}

func main() {
	// dat, err := ioutil.ReadFile("input.txt")
	// check(err)
	// // 

	// fmt.Print(dat.Size())
	// fmt.Print(string(dat))

	// Line by line
	file, err := os.Open("input.txt")
	check(err)
	defer file.Close()

	counter := 0

	scannerCount := bufio.NewScanner(file)

	for scannerCount.Scan() {
		counter++
	}

	file.Seek(0,0)
	scannerParse := bufio.NewScanner(file)

	for scannerParse.Scan() {
		// line := scanner.Text()
		fmt.Println(scannerParse.Text())
	}

	if err := scannerParse.Err(); err != nil {
		log.Fatal(err)
	}

	fmt.Println(counter)
}
