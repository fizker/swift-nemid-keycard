/// Credentials for using NemID keycards.
public struct NemIDCredentials: Codable, Equatable {
	/// The key in the DanID system. This can be used at `https://appletk.danid.dk/developers/viewstatus.jsp?userid=<key>`.
	public var id: Int
	/// The password for the identity. This is not secured.
	public var password: String
	/// The key cards currently issued to the identity.
	public var keycards: [Keycard]

	/// Creates a new ``NemIDCredentials``.
	/// - Parameter id: The key in the DanID system.
	/// - Parameter password: The password for the identity.
	/// - Parameter keyCards: The key cards currently issued to the identity.
	public init(id: Int, password: String, keycards: [Keycard]) {
		self.id = id
		self.password = password
		self.keycards = keycards
	}
}
