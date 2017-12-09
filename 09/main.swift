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
	return input
}


let input = getInput()
let clean = cleanGarbage(input: input)

print(clean)