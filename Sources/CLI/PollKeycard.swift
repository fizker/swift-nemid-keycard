import ArgumentParser

struct PollKeycard: ParsableCommand {
	@Argument(help: "The key to resolve.")
	var key: String

	@Flag(name: .shortAndLong, help: "Outputs the result as single line. Useful for piping into pbcopy.")
	var singleline: Bool

	@Option(name: .shortAndLong, help: "A specific keycard to use. If there is only one keycard, this can be omitted.")
	var keycard: String?

	mutating func run() throws {
		print("polling")
	}
}
