import struct Foundation.URL

enum CLIError: Error, CustomStringConvertible {
	case invalidURL(String)

	case dataNotFound(URL)

	case identityNotFound(String)
	case defaultIdentityNotFound
	case identityAmbiguous

	case keycardNotFound(String)
	case defaultKeycardNotFound
	case keycardAmbiguous

	case keycardKeyNotFound(String)

	var description: String {
		switch self {
		case let .invalidURL(string):
			return "Could not parse URL: \(string)."

		case let .dataNotFound(url):
			return "Could not find any data at path \(url.prettyFileString). Use the --data option to indicate an alternate path."

		case let .identityNotFound(cpr):
			return "Could not find any identity with CPR \(cpr). See the available identities with the list-identities command."
		case .defaultIdentityNotFound:
			return "No identities in the data set."
		case .identityAmbiguous:
			return "Please specify the identity with the --cpr option."

		case let .keycardNotFound(id):
			return "Could not find any keycards with ID \(id). See the available keycards with the list-keycards command."
		case .defaultKeycardNotFound:
			return "No keycards in the identity."
		case .keycardAmbiguous:
			return "Please specify the keycard ID with the --keycard option."

		case let .keycardKeyNotFound(key):
			return "Could not find a key with value \(key)."
		}
	}
}

enum CLICreateKeycardError: Error, CustomStringConvertible {
	case keycardKeyExists(key: String)
	case keycardCouldNotBeParsed
	case nemIDCredentialsMissing

	var description: String {
		switch self {
		case let .keycardKeyExists(key):
			return "Another keycard already exists with the same key: \(key)."
		case .keycardCouldNotBeParsed:
			return "Could not parse keycard."
		case .nemIDCredentialsMissing:
			return "Identity did not have NemID credentials. Please supply `--id` and `--password` to create new credentials."
		}
	}
}
