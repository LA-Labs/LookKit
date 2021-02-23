import XCTest

#if !canImport(ObjectiveC)
public func allTests() -> [XCTestCaseEntry] {
    return [
        testCase(LookKit_PackageTests.allTests),
    ]
}
#endif
