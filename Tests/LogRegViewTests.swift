//
//  LogRegViewTests.swift
//  MMLoginRegister
//
//  Created by Mikael Mukhsikaroyan on 11/21/16.
//  Copyright © 2016 MSquaredmm. All rights reserved.
//

import XCTest

class LogRegViewTests: XCTestCase {
    
    let login = LogRegView(frame: .zero)
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testDelegates() {
        class MockVC: UIViewController, LogRegViewDelegate {
            
            var loginCalled = false
            var registerCalled = false
            
            func login(withPassword password: String, username: String) {
                loginCalled = true
            }
            
            func register(withPassword password: String, username: String, email: String) {
                registerCalled = true
            }
        }
        let vc = MockVC()
        vc.view.addSubview(login)
        login.delegate = vc
        login.delegate?.login(withPassword: "secret", username: "bob")
        XCTAssert(vc.loginCalled, "Login delegate wasn't called")
        
        login.delegate?.register(withPassword: "secret", username: "Bob", email: "bob@example.com")
        XCTAssert(vc.registerCalled, "Register delegate wasn't called")
        
    }
    
    
    
}
