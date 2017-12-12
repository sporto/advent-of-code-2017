package main

import (
	"bufio"
	"fmt"
	"log"
	"os"
	"strings"
	"sort"
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

var matrix [ 2000 ][ 2000 ] int

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

func programsIn(pos int) []int {
	row := matrix[pos]
	var result []int

	for ix, v := range row {
		if v > 0 {
			result = append(result, ix)
		}
	}

	return result
}

func walk(seen map[int]bool, pos int) map[int]bool {
	exists := seen[pos]

	if exists {
		return seen
	} else {
		linked := programsIn(pos)

		seen[pos] = true

		for _, v := range linked {
			seen = walk(seen, v)
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

	// Part 1
	// How many programs are in the group that contains program ID 0?
	// seen := make(map[int]bool)
	// seen = walk(seen, 0)

	// fmt.Println(seen)
	// fmt.Println(len(seen))

	// Part 2
	seenList := []string{}
	for ix, _ := range matrix {
		seen := make(map[int]bool)
		seen = walk(seen, ix)

		// Get list of keys
		keys := make([]int, 0, len(seen))
		for k := range seen {
			keys = append(keys, k)
		}

		sort.Ints(keys)

		// Convert keys to strings
		keysStr := make([]string, 0, len(keys))
		for _, k := range keys {
			keysStr = append(keysStr, strconv.Itoa(k))
		}

		seenList = append(seenList, strings.Join(keysStr, "."))
	}

	// Find uniques
	uniques := make(map[string]bool)
	for _, k := range seenList {
		uniques[k] = true
	}

	fmt.Println(uniques)
	fmt.Println(len(uniques))
}
