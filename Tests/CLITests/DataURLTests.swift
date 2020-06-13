import XCTest
@testable import CLI

final class DataURLTests: XCTestCase {
	func test_description_fileURL_stripsTheScheme() {
		let url = URL(fileURLWithPath: "/some/url")
		let subject = DataURL(url: url)

		XCTAssertEqual(subject.description, "/some/url")
	}

	static var allTests = [
		("test_description_fileURL_stripsTheScheme", test_description_fileURL_stripsTheScheme),
	]
}
