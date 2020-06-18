import ArgumentParser
import NemIDKeycard

struct CreateKeycard: ParsableCommand {
	@Argument()
	var rawContent: String

	@OptionGroup()
	var options: IdentityOptions

	func run() throws {
		var data = try JSONData(url: options.dataURL)
		var identity = try data.identity(withCPR: options.cpr)

		guard let newKeycard = Keycard(string: rawContent)
		else { throw CLICreateKeycardError.keycardCouldNotBeParsed }

		guard !identity.keycards.contains(where: { $0.id == newKeycard.id })
		else { throw CLICreateKeycardError.keycardKeyExists(key: newKeycard.id) }

		identity.keycards.append(newKeycard)
		data.update(identity)
		try data.save()
	}
}
