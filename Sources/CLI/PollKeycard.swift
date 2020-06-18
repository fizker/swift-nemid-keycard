import ArgumentParser

struct PollKeycard: ParsableCommand {
	@Argument(help: "The key to resolve.")
	var key: String

	@Flag(name: .shortAndLong, help: "Outputs the result as single line. Useful for piping into pbcopy.")
	var singleLine: Bool

	@OptionGroup()
	var options: KeycardOptions

	mutating func run() throws {
		let data = try JSONData(url: options.dataURL)

		let keycard = try data.keycard(withID: options.keycardID, in: try data.identity(withCPR: options.cpr))

		if let value = keycard(key: key) {
			print(value, terminator: singleLine ? "" : "\n")
		} else {
			throw CLIError.keycardKeyNotFound(key)
		}
	}
}
