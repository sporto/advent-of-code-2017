package main

import (
	"bufio"
	"fmt"
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
	source  int
	targets []int
}

// 7 <-> 372, 743, 1965
func parseLine(line string) ParsedLine {
	parts := strings.Split(line, "<->")

	p1 := strings.Trim(parts[0], " ")
	source, err := strconv.ParseInt(p1, 10, 0)
	check(err)

	targetStrs := strings.Split(parts[1], ", ")

	var targets []int

	for _, str := range targetStrs {
		trimmed := strings.Trim(str, " ")
		n, err := strconv.ParseInt(trimmed, 10, 0)
		check(err)

		targets = append(targets, int(n))
	}

	return ParsedLine{
		source: int(source),
		targets: targets,
	}
}

func programsIn(matrix [2000][2000]int, pos int) []int {
	row := matrix[pos]
	var result []int

	for ix, v := range row {
		if v > 0 {
			result = append(result, ix)
		}
	}

	return result
}

func walk(matrix [2000][2000]int, seen map[int]bool, pos int) map[int]bool {
	exists := seen[pos]

	if exists {
		return seen
	} else {
		linked := programsIn(matrix, pos)

		seen[pos] = true

		fmt.Println(pos)
		fmt.Println(linked)
		fmt.Println(seen)

		for _, v := range linked {
			seen = walk(matrix, seen, v)
		}

		return seen
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

	var matrix [ 2000 ][ 2000 ] int

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

	// How many programs are in the group that contains program ID 0?
	seen := make(map[int]bool)
	seen = walk(matrix, seen, 0)
	
	// pos := 0

	// for {
	// 	exists := seen[pos]

	// 	if exists {
	// 		break
	// 	} else {
	// 		linked := programsIn(matrix, pos)

	// 		seen[pos] = true

	// 		// fmt.Println(pos)
	// 		// fmt.Println(linked)
	// 		// fmt.Println(seen)

	// 		for _, v := range linked {
	// 			seen = check(matrix, seen, v)
	// 		}

	// 		return seen
	// 	}
	// }

	fmt.Println(seen)

	// fmt.Println(matrix[1675][1022])
	// fmt.Println(matrix[1022][1675])
}
