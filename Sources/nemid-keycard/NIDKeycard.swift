/// Represents a NemID Key card
public struct NIDKeycard: Codable {
	/// The unique key of the card itself. Example: G750159724.
	public var id: String
	/// The keys, with request as the dictionary key and response as the value.
	public var keys: [String: String]

	/// Default initialiser
	/// - Parameter id: The ID of the card. Example: G750159724.
	/// - Parameter keys: A dictionary of key-value that the card contains.
	public init(id: String, keys: [String: String]) {
		self.id = id
		self.keys = keys
	}

	/// Returns the matching value from the dictionary. This is a shorthand for `card.keys[key]`.
	/// - Parameter key: The key to look up.
	/// - Returns: The matching value, or `nil` if no value was found.
	public subscript(key: String) -> String? { keys[key] }

	/// Returns the matching value from the dictionary. This is a shorthand for `card.keys[key]`.
	/// - Parameter key: The key to look up.
	/// - Returns: The matching value, or `nil` if no value was found.
	public func callAsFunction(key: String) -> String? { keys[key] }
}
