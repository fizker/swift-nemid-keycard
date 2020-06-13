import ArgumentParser

struct ListIdentities: ParsableCommand {
	@Option(default: DataURL(), transform: DataURL.init(string:))
	var dataPath: DataURL

	func run() throws {
		let data = try DataReader(url: dataPath)

		guard !data.identities.isEmpty
		else { return print("No identities found") }

		print("""
			Identities:
			\(data.identities.map { "- \($0.cpr) (\($0.name))" }.joined(separator: "\n"))
			"""
		)
	}
}
