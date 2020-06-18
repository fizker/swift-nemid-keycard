import XCTest

import CLITests
import NemIDKeycardTests

var tests = [XCTestCaseEntry]()
tests += CLITests.allTests()
tests += NemIDKeycardTests.allTests()
XCTMain(tests)
