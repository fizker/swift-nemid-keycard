import Foundation

/// Represents a personal identity in the NemLogIn system.
public struct Identity: Codable, Identifiable, Equatable {
	/// IdPs typically have multiple environments that have separate user lists. This allows an ``Identity`` to know which environment they exist within
	public enum Environment: String, Codable, CaseIterable {
		/// Represents the NemLog-in PreProd environment.
		case nemLogInPreProd = "NemLog-in PreProd"
		/// Represents the NemLog-in DevTet4 environment.
		case nemLogInDevTest4 = "NemLog-in DevTest4"
	}

	/// The CPR value is used to satisfy the `Identifiable` protocol.
	public var id: String { cpr }

	/// The environment that the user exists within.
	public var environment: Environment?

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
	/// - Parameter environment: The ``NemLogInEnvironment`` that the user exists within.
	/// - Parameter nemIDCredentials: Credentials for using NemID keycards.
	/// - Parameter mitIDCredentials: Credentials for using the MitID Test login service.
	public init(name: String, cpr: String, environment: Environment?, nemIDCredentials: NemIDCredentials?, mitIDCredentials: MitIDCredentials?) {
		self.name = name
		self.cpr = cpr
		self.environment = environment
		self.nemIDCredentials = nemIDCredentials
		self.mitIDCredentials = mitIDCredentials
	}

	public init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)
		self.name = try container.decode(String.self, forKey: .name)
		self.cpr = try container.decode(String.self, forKey: .cpr)
		self.environment = try container.decodeIfPresent(Environment.self, forKey: .environment)
		self.nemIDCredentials = try container.decodeIfPresent(NemIDCredentials.self, forKey: .nemIDCredentials)
		self.mitIDCredentials = try container.decodeIfPresent(MitIDCredentials.self, forKey: .mitIDCredentials)

		// Fallback to the old JSON version
		if nemIDCredentials == nil, let oldCredentials = try? NemIDCredentials(from: decoder) {
			nemIDCredentials = oldCredentials
		}
	}
}
