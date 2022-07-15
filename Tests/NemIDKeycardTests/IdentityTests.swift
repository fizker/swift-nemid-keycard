import Foundation
import XCTest
import NemIDKeycard

final class IdentityTests: XCTestCase {
	func test__initFromDecoder__v1JSON__decodesAsExpected() throws {
		let json = """
		{
		  "cpr" : "0101005143",
		  "id" : 778217849,
		  "keycards" : [
		    {
		      "id" : "O310143093",
		      "keys" : {
		        "0038" : "641616",
		        "0057" : "599373",
		        "0093" : "929235",
		        "9965" : "133251"
		      }
		    }
		  ],
		  "name" : "Thalia Nilsson",
		  "password" : "asasas12"
		}
		"""

		let actual = try decode(json)

		let expected = Identity(
			id: 778217849,
			name: "Thalia Nilsson",
			cpr: "0101005143",
			password: "asasas12",
			keycards: [
				.init(
					id: "O310143093",
					keys: [
						"0038": "641616",
						"0057": "599373",
						"0093": "929235",
						"9965": "133251",
					]
				)
			]
		)

		XCTAssertEqual(expected, actual)
	}

	func test__encodeToEncoder__v1JSON__encodesAsExpected() throws {
		let identity = Identity(
			id: 778217849,
			name: "Thalia Nilsson",
			cpr: "0101005143",
			password: "asasas12",
			keycards: [
				.init(
					id: "O310143093",
					keys: [
						"0038": "641616",
						"0057": "599373",
						"0093": "929235",
						"9965": "133251",
					]
				)
			]
		)

		let actual = try encode(identity)

		let expected = """
		{
		  "cpr" : "0101005143",
		  "id" : 778217849,
		  "keycards" : [
		    {
		      "id" : "O310143093",
		      "keys" : {
		        "0038" : "641616",
		        "0057" : "599373",
		        "0093" : "929235",
		        "9965" : "133251"
		      }
		    }
		  ],
		  "name" : "Thalia Nilsson",
		  "password" : "asasas12"
		}
		"""

		XCTAssertEqual(expected, actual)
	}

	func encode(_ identity: Identity) throws -> String {
		let encoder = JSONEncoder()
		encoder.outputFormatting = [ .sortedKeys, .prettyPrinted ]
		let data = try encoder.encode(identity)
		return String(data: data, encoding: .utf8)!
	}

	func decode(_ json: String) throws -> Identity {
		let decoder = JSONDecoder()
		let identity = try decoder.decode(Identity.self, from: json.data(using: .utf8)!)
		return identity
	}
}
