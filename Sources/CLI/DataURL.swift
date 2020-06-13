import Foundation

struct DataURL: CustomStringConvertible {
	enum E: Error {
		case invalidURL(String)
	}

	var url: URL

	var description: String {
		let path = url.absoluteString
		let fileScheme = "file://"
		if path.starts(with: fileScheme) {
			return path[fileScheme.endIndex...].description
		}
		return path
	}

	init(url: URL = URL(fileURLWithPath: "./data.json")) {
		self.url = url
	}

	init(string: String) throws {
		guard let url = URL(string: string, relativeTo: URL(fileURLWithPath: "."))
		else { throw E.invalidURL(string) }

		self.url = url
	}
}
