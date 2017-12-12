package main

import (
	"bufio"
	"fmt"
	// "io"
	// "io/ioutil"
	"log"
	"os"
	"strings"
	"strconv"
)

func check(e error) {
	if e != nil {
		panic(e)
	}
}

type ParsedLine struct {
	source  int64
	targets []int64
}

// 7 <-> 372, 743, 1965
func parseLine(line string) ParsedLine {
	parts := strings.Split(line, "<->")

	p1 := strings.Trim(parts[0], " ")
	source, err := strconv.ParseInt(p1, 10, 0)
	check(err)

	targetStrs := strings.Split(parts[1], ", ")

	var targets []int64

	for _, str := range targetStrs {
		trimmed := strings.Trim(str, " ")
		n, err := strconv.ParseInt(trimmed, 10, 0)
		check(err)

		targets = append(targets, n)
	}

	return ParsedLine{
		source: source,
		targets: targets,
	}
}

func main() {
	file, err := os.Open("input.txt")
	check(err)
	defer file.Close()

	counter := 0

	scannerCount := bufio.NewScanner(file)

	for scannerCount.Scan() {
		counter++
	}

	// Scan second time and parse lines
	file.Seek(0,0)
	scannerParse := bufio.NewScanner(file)

	var matrix [ 2000 ][ 2000 ] int64

	for scannerParse.Scan() {
		line := scannerParse.Text()
		parsed := parseLine(line)

		source := parsed.source

		for _,t := range parsed.targets {
			matrix[source][t] = 1
			matrix[t][source] = 1
		}
	}

	if err := scannerParse.Err(); err != nil {
		log.Fatal(err)
	}

	// fmt.Println(matrix)
	// fmt.Println(matrix[1675][1022])
	// fmt.Println(matrix[1022][1675])
}
