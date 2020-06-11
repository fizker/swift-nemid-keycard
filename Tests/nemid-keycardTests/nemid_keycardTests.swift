import XCTest
@testable import nemid_keycard

final class nemid_keycardTests: XCTestCase {
	func testExample() {
		// This is an example of a functional test case.
		// Use XCTAssert and related functions to verify your tests produce the correct
		// results.
		XCTAssertEqual(nemid_keycard().text, "Hello, World!")
	}

	static var allTests = [
		("testExample", testExample),
	]
}
