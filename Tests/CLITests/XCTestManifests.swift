import XCTest

#if !canImport(ObjectiveC)
public func allTests() -> [XCTestCaseEntry] {
	return [
		DataURLTests.allTests,
	]
}
#endif
