import Foundation

/// Represents a NemID Key card
public struct Keycard: Codable, Equatable, Identifiable {
	/// The unique key of the card itself. Example: `G750159724`.
	public var id: String
	/// The keys, with request as the dictionary key and response as the value.
	public var keys: [String: String]

	/// Default initialiser
	/// - Parameter id: The ID of the card. Example: `G750159724`.
	/// - Parameter keys: A dictionary of key-value that the card contains.
	public init(id: String, keys: [String: String]) {
		self.id = id
		self.keys = keys
	}

	/// Returns the matching value from ``keys``. This is a shorthand for `keycard.keys[key]`.
	/// - Parameter key: The key to look up.
	/// - Returns: The matching value, or `nil` if no value was found.
	public subscript(key: String) -> String? { keys[key] }

	/// Returns the matching value from ``keys``. This is a shorthand for `keycard.keys[key]`.
	/// - Parameter key: The key to look up.
	/// - Returns: The matching value, or `nil` if no value was found.
	public func callAsFunction(key: String) -> String? { keys[key] }
}

public extension Keycard {
	enum E: Error {
		case invalidPair(String)
	}

	/// Init that parses a normalised String value.
	/// The format comes from copying the content from DanID's site.
	///
	/// - Parameter string: The raw string that should be parsed.
	/// - Returns: The parsed `Keycard`, or `nil` if the input could not be parsed.
	///
	/// The format is a line first with the ID, then a header row that is ignored, followed by lines with the key-value parts
	/// The data-lines have two tabs between key-value pairs, and a single tab between key and value.
	///
	/// Example:
	/// ```
	/// Human-readable-text: <id of card>
	/// Human-readable header row
	/// 1234	123456		1234	123456		1234	123456
	/// 1234	123456		1234	123456		1234	123456
	/// 1234	123456		1234	123456		1234	123456
	/// 1234	123456		1234	123456		1234	123456
	/// ```
	init?(string raw: String) {
		let lines = raw.trimmingCharacters(in: .whitespacesAndNewlines).split { $0.isNewline }.map { $0.trimmingCharacters(in: .whitespaces) }

		guard let id = lines.first?.split(separator: ":").get(1)?.trimmingCharacters(in: .whitespaces)
		else { return nil }

		self.id = id

		guard let keyValuePairs = try? lines.dropFirst(2).flatMap({ line -> [(String, String)] in
			let pairs = line.components(separatedBy: "\t\t")
			return try pairs.map {
				let pair = $0.split(separator: "\t")
				guard pair.count == 2
				else { throw E.invalidPair($0) }

				return (String(pair[0]), String(pair[1]))
			}
		}), !keyValuePairs.isEmpty
		else { return nil }

		self.keys = [String:String](uniqueKeysWithValues: keyValuePairs)
	}
}

extension RandomAccessCollection {
	func get(_ index: Index) -> Element? {
		guard self.indices.contains(index)
		else { return nil }
		return self[index]
	}
}
