import ArgumentParser
import NemIDKeycard

struct CreateKeycard: ParsableCommand {
	@Argument()
	var rawContent: String

	@Option(name: .shortAndLong, help: "The ID for the NemID test user")
	var id: Int?

	@Option(name: .shortAndLong, help: "The password for the NemID test user")
	var password: String?

	@OptionGroup()
	var options: IdentityOptions

	func run() throws {
		var data = try JSONData(url: options.dataURL)
		var identity = try data.identity(withCPR: options.cpr)

		guard let newKeycard = Keycard(string: rawContent)
		else { throw CLICreateKeycardError.keycardCouldNotBeParsed }

		if identity.nemIDCredentials == nil, let id = id, let password = password {
			identity.nemIDCredentials = .init(id: id, password: password, keycards: [])
		}

		guard var nemID = identity.nemIDCredentials
		else { throw CLICreateKeycardError.nemIDCredentialsMissing }

		guard !nemID.keycards.contains(where: { $0.id == newKeycard.id })
		else { throw CLICreateKeycardError.keycardKeyExists(key: newKeycard.id) }

		nemID.keycards.append(newKeycard)
		identity.nemIDCredentials = nemID

		data.update(identity)
		try data.save()
	}
}
