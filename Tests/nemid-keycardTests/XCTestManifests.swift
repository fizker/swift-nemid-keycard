import XCTest

#if !canImport(ObjectiveC)
public func allTests() -> [XCTestCaseEntry] {
	return [
		testCase(nemid_keycardTests.allTests),
		testCase(NIDKeycardTests.allTests),
	]
}
#endif
