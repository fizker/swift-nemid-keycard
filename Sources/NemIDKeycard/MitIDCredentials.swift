/// Credentials for the MitID Test Login service.
public struct MitIDCredentials: Codable, Equatable {
	/// The username for the MitID Test Login service.
	public var username: String
	/// The password for the MitID Test Login service.
	public var password: String

	/// Creates a new ``MitIDCredentials``.
	/// - Parameter username: The login username.
	/// - Parameter password: The login password.
	public init(username: String, password: String) {
		self.username = username
		self.password = password
	}
}
