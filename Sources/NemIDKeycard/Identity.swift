import Foundation

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

/// Represents a personal identity in the NemID system.
public struct Identity: Codable, Identifiable, Equatable {
	/// The CPR value is used to satisfy the `Identifiable` protocol.
	public var id: String { cpr }

	/// The name of the identity.
	public var name: String
	/// The CPR number for the identity.
	public var cpr: String
	/// Associated credentials using NemID keycards.
	public var nemIDCredentials: NemIDCredentials?
	/// Associated test credentials for using MitID Test Login.
	public var mitIDCredentials: MitIDCredentials?

	/// The main init function.
	/// - Parameter name: The name of the identity.
	/// - Parameter cpr: The CPR number for the identity.
	/// - Parameter nemIDCredentials: Credentials for using NemID keycards.
	/// - Parameter mitIDCredentials: Credentials for using the MitID Test login service.
	public init(name: String, cpr: String, nemIDCredentials: NemIDCredentials?, mitIDCredentials: MitIDCredentials?) {
		self.name = name
		self.cpr = cpr
		self.nemIDCredentials = nemIDCredentials
		self.mitIDCredentials = mitIDCredentials
	}

	public init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)
		self.name = try container.decode(String.self, forKey: .name)
		self.cpr = try container.decode(String.self, forKey: .cpr)
		self.nemIDCredentials = try container.decodeIfPresent(NemIDCredentials.self, forKey: .nemIDCredentials)
		self.mitIDCredentials = try container.decodeIfPresent(MitIDCredentials.self, forKey: .mitIDCredentials)

		// Fallback to the old JSON version
		if nemIDCredentials == nil, let oldCredentials = try? NemIDCredentials(from: decoder) {
			nemIDCredentials = oldCredentials
		}
	}
}
