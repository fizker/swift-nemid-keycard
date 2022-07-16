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

		if let nemIDCredentials = identity.nemIDCredentials {
			print("""
				Keycards for \(identity.name) (\(identity.cpr)):
				\(nemIDCredentials.keycards.map { "- \($0.id)" }.joined(separator: "\n"))
				"""
			)
		} else {
			print("No NemID credentials present.")
		}

		if let mitIDCredentials = identity.mitIDCredentials {
			print("""
				MitID:
				- Username: \(mitIDCredentials.username)
				- Password: \(mitIDCredentials.password)
				""")
		} else {
			print("No MitID credentials present.")
		}
	}
}
