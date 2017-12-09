import Foundation

// Read input
let fileManager = FileManager.default
let dir = fileManager.currentDirectoryPath
let fileName = "input.txt"
let filePath = dir.appending("/" + fileName)
let fileURL = URL(fileURLWithPath: filePath)
let content = try String(contentsOf: fileURL, encoding: .utf8)

print(content)