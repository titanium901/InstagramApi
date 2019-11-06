//
//  LikeLikeInstagramUITests.swift
//  LikeLikeInstagramUITests
//
//  Created by Iury Popov on 06.11.2019.
//  Copyright © 2019 Iurii Popov. All rights reserved.
//

import XCTest

class LikeLikeInstagramUITests: XCTestCase {

    let app = XCUIApplication()
    var loginButton: XCUIElement!
    var emailTextField: XCUIElement!
    var passwordTextField: XCUIElement!
    let validPassword = "qwerty"
    let validEmail = "nemes901@hotmail.com"

    
    override func setUp() {
        
        XCUIApplication().launch()
        
        loginButton = app.buttons["Log In"]
        emailTextField = app.textFields["Email"]
        passwordTextField = app.secureTextFields["Password"]
        
        continueAfterFailure = false
        
    }
    
    func testInvalidLoginandCorrectPassword() {
        setupLoginandPassword(email: "nsnsnsn@mail.ru", password: validPassword)
        tapOnLoginandSeeAlert()
    }
    
    func testInvalidPasswordandCorrectLogin() {
        setupLoginandPassword(email: validEmail, password: "wewedwede")
        tapOnLoginandSeeAlert()
    }
    
    func testInvalidLoginMultyTimes() {
        for _ in 0...10 {
            tapOnLoginandSeeAlert()
        }
    }
    
    func testEmptyLoginandPassword() {
        tapOnLoginandSeeAlert()
    }
    
    func testValidLoginSuccess() {
        
        setupLoginandPassword(email: validEmail, password: validPassword)
        loginButton.tap()
      
        let setZeroButton = app.buttons["Set to 0 Like"]
        expectation(for: NSPredicate(format: "exists == 1"), evaluatedWith: setZeroButton, handler: nil)
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertTrue(setZeroButton.exists)
       
    }
    
    func setupLoginandPassword(email: String, password: String) {
        emailTextField.tap()
        emailTextField.typeText(email)
        passwordTextField.tap()
        passwordTextField.typeText(password)
    }
    
    func tapOnLoginandSeeAlert() {
        loginButton.tap()
        let alertDialog = app.alerts["Oops..."]
        XCTAssertTrue(alertDialog.exists)
        alertDialog.buttons["Ok"].tap()
    }

}
