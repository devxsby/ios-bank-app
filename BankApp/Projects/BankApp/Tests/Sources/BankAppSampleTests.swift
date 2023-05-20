import XCTest
@testable import BankApp

final class BankAppSampleTests: XCTestCase {
    
    var sut: Int!
    
    override func tearDownWithError() throws {
        sut = nil
    }
    
    func test_sample() {
        XCTAssertTrue(true)
    }
}
