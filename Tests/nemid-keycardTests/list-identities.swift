import XCTest
@testable import CLI

@available(OSX 10.13, *)
final class ListIdentitiesTests: XCTestCase {
	let commandName = "list-identities"

	func test_noDataFile_exitsWithError() throws {
		let process = TestProcess()
		let result = try process.execute(arguments: [ commandName ])

		XCTAssertNotEqual(0, result.exitCode)
		XCTAssertEqual(result.stderr, "Error: Could not find any data at path \(process.currentWorkingDirectory.appendingPathComponent("data.json").prettyFileString). Use the --data option to indicate an alternate path.\n")
	}
}
