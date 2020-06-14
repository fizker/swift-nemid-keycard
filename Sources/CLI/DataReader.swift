import Foundation
import NemIDKeycard
import ArgumentParser

struct DataReader {
	var identities: [Identity]

	init(url: DataURL) throws {
		let data: Data
		do {
			data = try Data(contentsOf: url.url)
		} catch {
			throw CLIError.dataNotFound(url.url)
		}
		let jsonDecoder = JSONDecoder()

		identities = try jsonDecoder.decode([Identity].self, from: data)
	}

	func identity(withCPR cpr: String) throws -> Identity {
		guard let ident = identities.first(where: { $0.cpr == cpr })
		else { throw CLIError.identityNotFound(cpr) }

		return ident
	}

	func identity(withCPR cpr: String?) throws -> Identity {
		if let cpr = cpr {
			return try identity(withCPR: cpr)
		} else {
			return try defaultIdentity()
		}
	}

	func defaultIdentity() throws -> Identity {
		guard let identity = identities.first
		else { throw CLIError.defaultIdentityNotFound }

		guard identities.count == 1
		else { throw CLIError.identityAmbiguous }

		return identity
	}

	func keycard(withID id: String?, in identity: Identity) throws -> Keycard {
		if let id = id {
			guard let keycard = identity.keycards.first(where: { $0.id == id })
			else { throw CLIError.keycardNotFound(id) }

			return keycard
		} else {
			guard let keycard = identity.keycards.first
			else { throw CLIError.defaultKeycardNotFound }

			return keycard
		}
	}
}

struct DataURLOptions: ParsableArguments {
	@Option(
		name: [ .short, .customLong("data") ],
		default: DataURL(),
		help: "The path to read the data from.",
		transform: DataURL.init(string:)
	)
	var dataURL: DataURL
}

struct IdentityOptions: ParsableArguments {
	@OptionGroup()
	var options: DataURLOptions

	@Option(name: .shortAndLong, help: "The CPR number of the identity. If there is only one identity, this can be omitted.")
	var cpr: String?

	var dataURL: DataURL { options.dataURL }
}

struct KeycardOptions: ParsableArguments {
	@OptionGroup()
	var options: IdentityOptions

	@Option(name: [ .short, .customLong("keycard") ], help: "A specific keycard to use. If there is only one keycard, this can be omitted.")
	var keycardID: String?

	var cpr: String? { options.cpr }
	var dataURL: DataURL { options.dataURL }
}
