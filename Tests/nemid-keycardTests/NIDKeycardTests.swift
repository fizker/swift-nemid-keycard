import XCTest
import nemid_keycard

final class NIDKeycardTests: XCTestCase {
	let card = NIDKeycard(id: "FOO123", keys: ["1234": "123456", "4321": "654321"])

	func test_subscript_keyExists_returnsValue() {
		XCTAssertEqual(card["1234"], "123456")
		XCTAssertEqual(card["4321"], "654321")
	}

	func test_subscript_keyDoesNotExists_returnsNil() {
		XCTAssertNil(card["foo"])
		XCTAssertNil(card["2341"])
	}

	func test_callable_keyExists_returnsValue() {
		XCTAssertEqual(card(key: "1234"), "123456")
		XCTAssertEqual(card(key: "4321"), "654321")
	}

	func test_callable_keyDoesNotExists_returnsNil() {
		XCTAssertNil(card(key: "foo"))
		XCTAssertNil(card(key: "2341"))
	}


	static var allTests = [
		("test_subscript_keyExists_returnsValue", test_subscript_keyExists_returnsValue),
		("test_subscript_keyDoesNotExists_returnsNil", test_subscript_keyDoesNotExists_returnsNil),
		("test_callable_keyExists_returnsValue", test_callable_keyExists_returnsValue),
		("test_callable_keyDoesNotExists_returnsNil", test_callable_keyDoesNotExists_returnsNil),
	]
}
