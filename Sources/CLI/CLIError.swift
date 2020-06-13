enum CLIError: Error, CustomStringConvertible {
	case identityNotFound(String)
	case defaultIdentityNotFound
	case identityAmbiguous

	case keycardNotFound(String)
	case defaultKeycardNotFound
	case keycardAmbiguous

	case keycardKeyNotFound(String)

	var description: String {
		switch self {
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
