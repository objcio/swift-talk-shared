import XCTest
@testable import swift_talk_shared

final class swift_talk_sharedTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(swift_talk_shared().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
