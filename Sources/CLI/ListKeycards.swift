import ArgumentParser
import NemIDKeycard

struct ListKeycards: ParsableCommand {
	@Option(default: DataURL(), transform: DataURL.init(string:))
	var dataPath: DataURL

	@Option(name: .shortAndLong)
	var cpr: String?

	func run() throws {
		let data = try JSONData(url: dataPath)

		let identity = try data.identity(withCPR: cpr)

		print("""
			Keycards for \(identity.name) (\(identity.cpr)):
			\(identity.keycards.map { "- \($0.id)" }.joined(separator: "\n"))
			"""
		)
	}
}
