//
//  CreateTransactionsTests.swift
//  SplitCircleTests
//
//  Created by XIANGYU KONG on 5/18/24.
//

import XCTest
@testable import SplitCircle

final class CreateTransactionsTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testCreateTransactions() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
        let userAlice = User(id: "1", name: "Alice")
        let userBob = User(id: "2", name: "Bob")
        let userTom = User(id: "1", name: "Tom")

        
        let expenseTitle = "Dinner"
        let expenseAmount = 100.0
        let expensePayers = [userAlice]
        let expensePayees = [userAlice, userBob, userTom]
        
//        let transactions = createTransactions(expenseAmount: expenseAmount, expenseTitle: expenseTitle, expensePayees: expensePayees, expensePayers: expensePayers)
//        XCTAssertEqual(transactions.count, 1)
//        let transaction1 = transactions.first { $0.payer.name == "Alice" && $0.payee.name == "Bob" }
//        XCTAssertNotNil(transaction1)
//        XCTAssertEqual(transaction1?.amount, 50.0)
//        print(transactions)
//
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
