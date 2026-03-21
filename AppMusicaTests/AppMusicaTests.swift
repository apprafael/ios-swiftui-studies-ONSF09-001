//
//  AppMusicaTests.swift
//  AppMusicaTests
//
//  Created by Rafael Almeida on 21/03/26.
//

import XCTest
@testable import AppMusica

final class AppMusicaTests: XCTestCase {
    
    var viewModel: LoginViewModel?

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        viewModel = LoginViewModel()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testLoginSuccees() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
        viewModel?.accounts = [UserAccount(name: "rafael", username: "teste@teste.com", password: "123456")]
        
        viewModel?.user = "teste@teste.com"
        viewModel?.password = "123456"
        
        XCTAssert(viewModel?.login() ?? false)
    }
    
    func testLoginEmpty() throws {
        viewModel?.accounts = [UserAccount(name: "rafael", username: "teste@teste.com", password: "123456")]
        
        viewModel?.user = ""
        viewModel?.password = ""
        
        XCTAssert(!(viewModel?.login() ?? false))
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }
}
