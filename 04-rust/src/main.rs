use std::fs::File;
use std::io::prelude::*;
use std::collections::HashMap;

fn get_input() -> String {
	let filename = "input.txt".to_string();
	let mut f = File::open(filename).expect("file not found");

	let mut contents = String::new();

	f.read_to_string(&mut contents)
		.expect("something went wrong reading the file");

	contents
}

fn is_valid(line: &str) -> usize {
	let words = line
		.split_whitespace();

	let uniques: HashMap<_, _> = words
		.clone()
		.map(|w| (w, 1))
		.collect();

	let dups = words.count() - uniques.len();
	
	if dups == 0 {
		1
	} else {
		0
	}
}

fn main() {
	let input = get_input();

	let res: usize = input
		.lines()
		.map(is_valid)
		.sum();

	println!("{}", res);
}