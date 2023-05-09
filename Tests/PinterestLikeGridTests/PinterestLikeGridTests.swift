import XCTest

@testable import PinterestLikeGrid

final class PinterestLikeGridTests: XCTestCase {
    
    func testSplitDataWithEmptyArray() {
        let arr: [Int] = []
        XCTAssertEqual(Helper.splitData(from: arr), [])
        XCTAssertEqual(Helper.splitData(from: arr, into: 3), [])
    }
    
    func testSplitDataWithColumnsGreaterThanLength() {
        for i in 6...10 {
            let arr = [1,2,3,4,5,6]
            let expected = [[1],[2],[3],[4],[5],[6]]
            XCTAssertEqual(Helper.splitData(from: arr, into: i), expected)
        }
    }
    
    func testSplitDataWithLengthGreaterThanColumns() {
        let arr = ["a","b","c","d","e","f","g"]
        let expected = [["a","d","g"],["b","e"],["c","f"]]
        XCTAssertEqual(Helper.splitData(from: arr, into: 3), expected)
    }
    
    func testSplitDataWithColumnsEqualToLength() {
        let arr = ["a","b","c","d"]
        let expected = [["a"],["b"],["c"],["d"]]
        XCTAssertEqual(Helper.splitData(from: arr, into: 4), expected)
    }
    
    func testSplitDataWithDouble() {
        let arr = [0.4,1.5,9.8,25.0,61.4,3.2]
        let expected = [[0.4,3.2],[1.5],[9.8],[25.0],[61.4]]
        XCTAssertEqual(Helper.splitData(from: arr, into: 5), expected)
    }
}
