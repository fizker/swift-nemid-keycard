import ArgumentParser
import Foundation
import NemIDKeycard

let dummyData = [
	Identity(
		danIDKey: 1234,
		name: "Foo bar",
		cpr: "1234567890",
		password: "very secure",
		keycards: [
			Keycard(id: "ABC123", keys: [
				"firstKey": "firstValue",
				"secondKey": "secondValue",
			]),
		]
	),
]

struct CreateDummyData: ParsableCommand {
	@Argument(default: DataURL(), help: "The path where the dummy data should be created", transform: DataURL.init(string:))
	var outputPath: DataURL

	func run() throws {
		let encoder = JSONEncoder()
		if #available(OSX 10.15, *) {
			encoder.outputFormatting = [
				.withoutEscapingSlashes,
				.prettyPrinted,
			]
		} else {
			encoder.outputFormatting = .prettyPrinted
		}
		let data = try encoder.encode(dummyData)

		try data.write(to: outputPath.url)

		print("Dummy data created at \(outputPath)")
	}
}
