import Foundation

/// Represents a personal identity in the NemID system.
public struct Identity: Codable, Identifiable, Equatable {
	/// The key in the DanID system. This can be used at `https://appletk.danid.dk/developers/viewstatus.jsp?userid=<key>`.
	public var id: Int
	/// The name of the identity.
	public var name: String
	/// The CPR number for the identity.
	public var cpr: String
	/// The password for the identity. This is not secured.
	public var password: String
	/// The key cards currently issued to the identity.
	public var keycards: [Keycard]

	/// The main init function.
	/// - Parameter id: The key in the DanID system.
	/// - Parameter name: The name of the identity.
	/// - Parameter cpr: The CPR number for the identity.
	/// - Parameter password: The password for the identity.
	/// - Parameter keyCards: The key cards currently issued to the identity.
	public init(id: Int, name: String, cpr: String, password: String, keycards: [Keycard]) {
		self.id = id
		self.name = name
		self.cpr = cpr
		self.password = password
		self.keycards = keycards
	}
}
