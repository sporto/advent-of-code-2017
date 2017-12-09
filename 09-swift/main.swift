import Foundation

func getInput() -> String {
	let fileManager = FileManager.default
	let dir = fileManager.currentDirectoryPath
	let fileName = "input.txt"
	let filePath = dir.appending("/" + fileName)
	let fileURL = URL(fileURLWithPath: filePath)
	var content = ""

	do {
		content = try String(contentsOf: fileURL, encoding: .utf8)
	}
	catch let error as NSError {
		print("An error took place: \(error)")
	}

	return content
}

func cleanGarbage(input: String) -> (String, Int) {
	let initial = (result: "", isGarbage: false, cancel: false, charsInGarbage: 0)

	let result = input.characters.reduce(initial, {acc, c in
		if acc.cancel {
			return (
				result: acc.result, 
				isGarbage: acc.isGarbage, 
				cancel: false,
				charsInGarbage: acc.charsInGarbage
			)
		} else {
			if c == "!" {
				return (
					result: acc.result,
					isGarbage: acc.isGarbage,
					cancel: true,
					charsInGarbage: acc.charsInGarbage
				)
			} else {
				if acc.isGarbage {
					if c == ">" {
						// Close garbage
						return (
							result: acc.result,
							isGarbage: false,
							cancel: false,
							charsInGarbage: acc.charsInGarbage
						)
					} else {
						return (
							result: acc.result,
							isGarbage: true,
							cancel: false,
							charsInGarbage: acc.charsInGarbage + 1
						)
					}
				} else {
					if c == "<" {
						// Start garbage
						return (
							result: acc.result,
							isGarbage: true,
							cancel: false,
							charsInGarbage: acc.charsInGarbage
						)
					} else {
						if c == "," {
							return (
								result: acc.result,
								isGarbage: false,
								cancel: false,
								charsInGarbage: acc.charsInGarbage
							)
						} else {
							return (
								result: "\(acc.result)\(c)",
								isGarbage: false,
								cancel: false,
								charsInGarbage: acc.charsInGarbage
							)
						}
					}
				}
			}
		}
	})

	return (
		result.result.trimmingCharacters(in: .whitespacesAndNewlines),
		result.charsInGarbage
	)
}

func score(input: String) -> Int {
	let initial = (result: 0, currentLevel: 1)
	let result = input.characters.reduce(initial, {acc, c in
		if c == "{" {
			return (result: acc.result + acc.currentLevel, acc.currentLevel + 1)
		} else {
			return (result: acc.result, acc.currentLevel - 1)
		}
	})

	return result.result
}


let input = getInput()
let (clean, charsInGarbage) = cleanGarbage(input: input)
let levels = score(input: clean)

print(levels)
print(charsInGarbage)