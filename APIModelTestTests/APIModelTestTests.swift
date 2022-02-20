//
//  APIModelTestTests.swift
//  APIModelTestTests
//
//  Created by Ryota Karita on 2022/02/18.
//

import XCTest
@testable import APIModelTest

class APIModelTestTests: XCTestCase {
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }
    
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testMajorRepositories() {
        let testRepos: [GitHubRepository] = [
            GitHubRepository(id: 0, star: 4, name: ""),
            GitHubRepository(id: 1, star: 5, name: ""),
            GitHubRepository(id: 2, star: 6, name: ""),
        ]
        
        let mockClient = MockGitHubAPIClient(repos: testRepos)
        
        let manager = GitHubRepositoryManager(client: mockClient)
        
        manager.load(user: "apple   ") {
            XCTAssertEqual(mockClient.argsUser, "apple")
            
            XCTAssertEqual(manager.majorRepositories.count, 2)
            XCTAssertEqual(manager.majorRepositories[0].id, 1)
            XCTAssertEqual(manager.majorRepositories[1].id, 2)
            
        }
    }
    
    func testEcho() {
        let exp: XCTestExpectation = expectation(description: "wait for finish")
        echo(message: "Hello") { message in
            XCTAssertEqual(message, "Hello!")
//            XCTFail()
            exp.fulfill()
        }
        
        wait(for: [exp], timeout: 5)
    }
    
    func testIsHoliday() {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd"
        
        var date: Date!
        
        date = formatter.date(from: "2019/01/06")
        XCTAssertTrue(isHoliday(date: date))
        
        date = formatter.date(from: "2019/01/07")
        XCTAssertFalse(isHoliday(date: date))
        
        date = formatter.date(from: "2019/01/11")
        XCTAssertFalse(isHoliday(date: date))
        
        date = formatter.date(from: "2019/01/12")
        XCTAssertTrue(isHoliday(date: date))
    }
    
}

func echo (message: String, handler: @escaping (String) -> Void) {
    DispatchQueue.global().async {
        Thread.sleep(forTimeInterval: 3)
        
        DispatchQueue.main.async {
            handler("\(message)!")
        }
    }
}

func isHoliday(date: Date = Date()) -> Bool {
//    let now = Date()
    
    let calendar = Calendar.current
    let weekday = calendar.component(.weekday, from: date)
    
    return weekday == 1 || weekday == 7
}
