import XCTest
import NemIDKeycard

final class KeycardTests: XCTestCase {
	let card = Keycard(id: "FOO123", keys: ["1234": "123456", "4321": "654321"])

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

	func test_equals() {
		let tests:[(expected: Bool, a: Keycard, b: Keycard)] = [
			(true, Keycard(id: "F123", keys: [:]), Keycard(id: "F123", keys: [:])),
			(true, Keycard(id: "F123", keys: ["a":"1"]), Keycard(id: "F123", keys: ["a":"1"])),
			(false, Keycard(id: "F123", keys: [:]), Keycard(id: "F1234", keys: [:])),
			(false, Keycard(id: "F123", keys: ["a":"1"]), Keycard(id: "F123", keys: ["a":"2"])),
			(false, Keycard(id: "F123", keys: ["a":"1"]), Keycard(id: "F123", keys: ["b":"1"])),
		]

		for (expected, a, b) in tests {
			XCTAssertEqual(a == b, expected)
			XCTAssertEqual(b == a, expected)
		}
	}

	func test_initWithDSL_validDSL_returnsCard() {
		let input = """
			Nøglekortnummer: G750159724
			 Nøgle nr.	Nøgle		 Nøgle nr.	Nøgle		 Nøgle nr.	Nøgle		 Nøgle nr.	Nøgle
			0063	103749		2734	413128		5147	625409		7779	946731
			0087	972967		2797	862321		5164	160737		7991	420288
			0090	873699		2822	439994		5213	600908		8032	089708
			0168	940246		2833	054156		5219	618608		8124	704504
			0203	044151		2856	879079		5230	830451		8168	727702
			"""

		let expected = Keycard(id: "G750159724", keys: [
			"0063": "103749", "2734": "413128", "5147": "625409", "7779": "946731",
			"0087": "972967", "2797": "862321", "5164": "160737", "7991": "420288",
			"0090": "873699", "2822": "439994", "5213": "600908", "8032": "089708",
			"0168": "940246", "2833": "054156", "5219": "618608", "8124": "704504",
			"0203": "044151", "2856": "879079", "5230": "830451", "8168": "727702",
		])

		let actual = Keycard(string: input)
		XCTAssertEqual(expected, actual)
	}

	func test_initWithDSL_invalidDSLs_returnsNil() {
		let inputs:[String] = [
			"""
			Foo: no tabs in data rows
			title row
			123: 321
			""",
			"one row only",
			"""
			key: No data rows
			title row
			""",
			"""
			no key row
			title row
			123\t321
			"""
		]

		for input in inputs {
			XCTAssertNil(Keycard(string: input), input)
		}
	}

	static var allTests = [
		("test_subscript_keyExists_returnsValue", test_subscript_keyExists_returnsValue),
		("test_subscript_keyDoesNotExists_returnsNil", test_subscript_keyDoesNotExists_returnsNil),
		("test_callable_keyExists_returnsValue", test_callable_keyExists_returnsValue),
		("test_callable_keyDoesNotExists_returnsNil", test_callable_keyDoesNotExists_returnsNil),
		("test_initWithDSL_validDSL_returnsCard", test_initWithDSL_validDSL_returnsCard),
		("test_initWithDSL_invalidDSLs_returnsNil", test_initWithDSL_invalidDSLs_returnsNil),
	]
}
