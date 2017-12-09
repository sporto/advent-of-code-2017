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

func cleanGarbage(input: String) -> String {
	let initial = (result: "", isGarbage: false, cancel: false)

	let result = input.characters.reduce(initial, {acc, c in
		if acc.cancel {
			return (result: acc.result, isGarbage: acc.isGarbage, cancel: false)
		} else {
			if c == "!" {
				return (result: acc.result, isGarbage: acc.isGarbage, cancel: true)
			} else {
				if acc.isGarbage {
					if c == ">" {
						return (result: acc.result, isGarbage: false, cancel: false)
					} else {
						return (result: acc.result, isGarbage: true, cancel: false)
					}
				} else {
					if c == "<" {
						return (result: acc.result, isGarbage: true, cancel: false)
					} else {
						if c == "," {
							return (result: acc.result, isGarbage: false, cancel: false)
						} else {
							return (result: "\(acc.result)\(c)", isGarbage: false, cancel: false)
						}
					}
				}
			}
		}
	})

	return result.result.trimmingCharacters(in: .whitespacesAndNewlines)
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
let clean = cleanGarbage(input: input)
let levels = score(input: clean)

print(levels)