import Foundation

extension URL {
	var prettyFileString: String {
		let path = absoluteString
		let fileScheme = "file://"
		if path.starts(with: fileScheme) {
			return path[fileScheme.endIndex...].description
		}
		return path
	}
}

struct DataURL: CustomStringConvertible {
	var url: URL

	var description: String { url.prettyFileString }

	init(url: URL = URL(fileURLWithPath: "./data.json")) {
		self.url = url
	}

	init(string: String) throws {
		guard let url = URL(string: string, relativeTo: URL(fileURLWithPath: "."))
		else { throw CLIError.invalidURL(string) }

		self.url = url
	}
}
