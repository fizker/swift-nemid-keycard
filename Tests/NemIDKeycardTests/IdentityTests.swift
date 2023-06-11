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
			name: "Thalia Nilsson",
			cpr: "0101005143",
			environment: nil,
			nemIDCredentials: .init(
				id: 778217849,
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
			),
			mitIDCredentials: nil
		)

		XCTAssertEqual(expected, actual)
	}

	func test__initFromDecoder__nemIDCredentialsPresent_mitIDCredentialsMissing__decodesAsExpected() throws {
		let json = """
		{
		  "cpr" : "0101005143",
		  "name" : "Thalia Nilsson",
		  "nemIDCredentials" : {
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
		    "password" : "asasas12"
		  }
		}
		"""

		let actual = try decode(json)

		let expected = Identity(
			name: "Thalia Nilsson",
			cpr: "0101005143",
			environment: nil,
			nemIDCredentials: .init(
				id: 778217849,
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
			),
			mitIDCredentials: nil
		)

		XCTAssertEqual(expected, actual)
	}

	func test__encodeToEncoder__nemIDCredentialsPresent_mitIDCredentialsMissing__encodesAsExpected() throws {
		let identity = Identity(
			name: "Thalia Nilsson",
			cpr: "0101005143",
			environment: nil,
			nemIDCredentials: .init(
				id: 778217849,
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
			),
			mitIDCredentials: nil
		)

		let actual = try encode(identity)

		let expected = """
		{
		  "cpr" : "0101005143",
		  "name" : "Thalia Nilsson",
		  "nemIDCredentials" : {
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
		    "password" : "asasas12"
		  }
		}
		"""

		XCTAssertEqual(expected, actual)
	}

	func test__initFromDecoder__nemIDCredentialsMissing_mitIDCredentialsPresent__decodesAsExpected() throws {
		let json = """
		{
		  "cpr" : "0101005143",
		  "name" : "Thalia Nilsson",
		  "mitIDCredentials" : {
		    "password" : "asasas12",
		    "username" : "foo"
		  }
		}
		"""

		let actual = try decode(json)

		let expected = Identity(
			name: "Thalia Nilsson",
			cpr: "0101005143",
			environment: nil,
			nemIDCredentials: nil,
			mitIDCredentials: .init(username: "foo", password: "asasas12")
		)

		XCTAssertEqual(expected, actual)
	}

	func test__encodeToEncoder__nemIDCredentialsMissing_mitIDCredentialsPresent__encodesAsExpected() throws {
		let identity = Identity(
			name: "Thalia Nilsson",
			cpr: "0101005143",
			environment: nil,
			nemIDCredentials: nil,
			mitIDCredentials: .init(username: "foo", password: "asasas12")
		)

		let actual = try encode(identity)

		let expected = """
		{
		  "cpr" : "0101005143",
		  "mitIDCredentials" : {
		    "password" : "asasas12",
		    "username" : "foo"
		  },
		  "name" : "Thalia Nilsson"
		}
		"""

		XCTAssertEqual(expected, actual)
	}

	func test__initFromDecoder__nemIDCredentialsPresent_mitIDCredentialsPresent__decodesAsExpected() throws {
		let json = """
		{
		  "cpr" : "0101005143",
		  "name" : "Thalia Nilsson",
		  "mitIDCredentials" : {
		    "password" : "asasas12",
		    "username" : "foo"
		  },
		  "nemIDCredentials" : {
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
		    "password" : "asasas12"
		  }
		}
		"""

		let actual = try decode(json)

		let expected = Identity(
			name: "Thalia Nilsson",
			cpr: "0101005143",
			environment: nil,
			nemIDCredentials: .init(
				id: 778217849,
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
			),
			mitIDCredentials: .init(username: "foo", password: "asasas12")
		)

		XCTAssertEqual(expected, actual)
	}

	func test__encodeToEncoder__nemIDCredentialsPresent_mitIDCredentialsPresent__encodesAsExpected() throws {
		let identity = Identity(
			name: "Thalia Nilsson",
			cpr: "0101005143",
			environment: nil,
			nemIDCredentials: .init(
				id: 778217849,
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
			),
			mitIDCredentials: .init(username: "foo", password: "asasas12")
		)

		let actual = try encode(identity)

		let expected = """
		{
		  "cpr" : "0101005143",
		  "mitIDCredentials" : {
		    "password" : "asasas12",
		    "username" : "foo"
		  },
		  "name" : "Thalia Nilsson",
		  "nemIDCredentials" : {
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
		    "password" : "asasas12"
		  }
		}
		"""

		XCTAssertEqual(expected, actual)
	}

	func test__initWithDecoder__environmentIsPresent_environmentIsAKnownValue__decodesAsExpected() throws {
		let identities: [Identity] = [
			.init(
				name: "preprod",
				cpr: "1234567890",
				environment: .nemLogInPreProd,
				nemIDCredentials: nil,
				mitIDCredentials: nil
			),
			.init(
				name: "devtest4",
				cpr: "1234567890",
				environment: .nemLogInDevTest4,
				nemIDCredentials: nil,
				mitIDCredentials: nil
			),
		]

		XCTAssertEqual(identities.count, Identity.Environment.allCases.count, "All environments should be tested")

		let json = """
		[
		  {
		    "cpr" : "1234567890",
		    "environment" : "NemLog-in PreProd",
		    "name" : "preprod"
		  },
		  {
		    "cpr" : "1234567890",
		    "environment" : "NemLog-in DevTest4",
		    "name" : "devtest4"
		  }
		]
		"""

		let actual = try decode(json, to: [Identity].self)

		XCTAssertEqual(identities, actual)
	}

	func test__encodeToEncoder__environmentIsSet__encodesAsExpected() throws {
		let identities: [Identity] = [
			.init(
				name: "preprod",
				cpr: "1234567890",
				environment: .nemLogInPreProd,
				nemIDCredentials: nil,
				mitIDCredentials: nil
			),
			.init(
				name: "devtest4",
				cpr: "1234567890",
				environment: .nemLogInDevTest4,
				nemIDCredentials: nil,
				mitIDCredentials: nil
			),
		]

		XCTAssertEqual(identities.count, Identity.Environment.allCases.count, "All environments should be tested")

		let expected = """
		[
		  {
		    "cpr" : "1234567890",
		    "environment" : "NemLog-in PreProd",
		    "name" : "preprod"
		  },
		  {
		    "cpr" : "1234567890",
		    "environment" : "NemLog-in DevTest4",
		    "name" : "devtest4"
		  }
		]
		"""

		let actual = try encode(identities)

		XCTAssertEqual(expected, actual)
	}

	func encode(_ identity: some Codable) throws -> String {
		let encoder = JSONEncoder()
		encoder.outputFormatting = [ .sortedKeys, .prettyPrinted ]
		let data = try encoder.encode(identity)
		return String(data: data, encoding: .utf8)!
	}

	func decode<T: Decodable>(_ json: String, to type: T.Type = Identity.self) throws -> T {
		let decoder = JSONDecoder()
		let identity = try decoder.decode(T.self, from: json.data(using: .utf8)!)
		return identity
	}
}
