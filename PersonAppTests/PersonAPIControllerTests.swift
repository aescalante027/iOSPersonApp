//
//  PersonAPIControllerTests.swift
//  PersonAppTests
//
//  Created by Alex Escalante on 11/9/22.
//

import XCTest
@testable import PersonApp

final class PersonAPIControllerTests: XCTestCase {
    
    private let controller = PersonAPIController()

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testSinglePersonPull() throws {
        let expectation = XCTestExpectation(description: "Single Person API call")
        var actualPerson = Person()
        let expectedPerson = Person(id: 3, firstname: "Taylor", lastname: "Swift", age: 32)
        
        controller.getSinglePersonData(id: 3) { result in
            if let person = result {
                actualPerson = person
            }
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 5.0)
        
        XCTAssertEqual(expectedPerson, actualPerson)
    }
    
    func testGetAllPeople() throws {
        let expectation = XCTestExpectation(description: "All People API call")
        var peopleData: [String:Any] = [:]
        
        controller.getAllPeopleData() { result in
            peopleData = result
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 5.0)
        XCTAssertFalse(peopleData.isEmpty)
    }
    
    func testUpdatePersonAge() throws {
        let expectation = XCTestExpectation(description: "Updating person's age")
        var actualPerson = Person()
        var expectedPerson = Person(id: 6, firstname: "Troy", lastname: "McClure", age: 25)
        
        controller.updatePersonAge(id: 6, age: 25) { result in
            actualPerson = result
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 5.0)
        XCTAssertEqual(expectedPerson, actualPerson)
        
        expectedPerson.age = 55
        let revertExpectation = XCTestExpectation(description: "Reverting age change")
        
        controller.updatePersonAge(id: 6, age: 55) { result in
            actualPerson = result
            revertExpectation.fulfill()
        }
        wait(for: [revertExpectation], timeout: 5.0)
        XCTAssertEqual(expectedPerson, actualPerson)
    }
    
    func testUpdatePersonLastName() throws {
        let expectation = XCTestExpectation(description: "Updating person's last name")
        var actualPerson = Person()
        var expectedPerson = Person(id: 3, firstname: "Taylor", lastname: "Sjoberg", age: 32)
        
        controller.updatePersonLastName(id: 3, lastname: "Sjoberg") { result in
            actualPerson = result
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 5.0)
        XCTAssertEqual(expectedPerson, actualPerson)
        
        expectedPerson.lastname = "Swift"
        let revertExpectation = XCTestExpectation(description: "Reverting name change")
        
        controller.updatePersonLastName(id: 3, lastname: "Swift") { result in
            actualPerson = result
            revertExpectation.fulfill()
        }
        wait(for: [revertExpectation], timeout: 5.0)
        XCTAssertEqual(expectedPerson, actualPerson)
    }

}
