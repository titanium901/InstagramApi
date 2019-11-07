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
    
    let validPassword = "qwerty"
    let validEmail = "nemes901@hotmail.com"
    
    // MARK: Login VC Elements
    var loginButton: XCUIElement!
    var emailTextField: XCUIElement!
    var passwordTextField: XCUIElement!
    
    // MARK: Profile VC Elements
    var moreButton: XCUIElement!
    var exitButton: XCUIElement!
    var circleMenuButton: XCUIElement!
    var icons8HeartsButton: XCUIElement!
    var setZeroButton: XCUIElement!
    var likeLabel: XCUIElement!
    
    override func setUp() {
        
        XCUIApplication().launch()
        
        loginButton = app.buttons["Log In"]
        emailTextField = app.textFields["Email"]
        passwordTextField = app.secureTextFields["Password"]
        
        moreButton = app.buttons["more"]
        exitButton = app.buttons["Exit"]
        circleMenuButton = app.buttons["icons8 circled menu"]
        icons8HeartsButton = app.buttons["icons8 hearts"]
        setZeroButton = app.buttons["Set to 0 Like"]
        likeLabel = app.staticTexts["0"]
        
        continueAfterFailure = false
        
    }
    
    
    // MARK: Tests
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
      
        expectation(for: NSPredicate(format: "exists == 1"), evaluatedWith: setZeroButton, handler: nil)
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertTrue(setZeroButton.exists)
       
    }
    
    func testLoginLogOutSeveralTimes() {
        setupLoginandPassword(email: validEmail, password: validPassword)
        loginButton.tap()
        moreButton.tap()
        expectation(for: NSPredicate(format: "exists == 1"), evaluatedWith: exitButton, handler: nil)
        waitForExpectations(timeout: 5, handler: nil)
        sleep(1)
        exitButton.tap()
        
        for _ in 0...3 {
            sleep(2)
            passwordTextField.doubleTap()
            sleep(2)
            passwordTextField.typeText(validPassword)
            loginButton.tap()
            moreButton.tap()
            exitButton.tap()
        }
        
    }
    
    // MARK: Tests Profile VC
    func testLikeIncrements() {
        
        setupLoginandPassword(email: validEmail, password: validPassword)
        loginButton.tap()
        
        circleMenuButton.tap()
        var index = 0
        for _ in 0...5 {
            index += 1
            icons8HeartsButton.tap()
            XCTAssertTrue(app.staticTexts["\(index)"].exists)
        }
    }
    
    func testZeroLikesByTapOnZeroButton() {
        setupLoginandPassword(email: validEmail, password: validPassword)
        loginButton.tap()
        circleMenuButton.tap()
        sleep(1)
        icons8HeartsButton.tap()
        sleep(1)
        XCTAssertTrue(app.staticTexts["1"].exists)
        setZeroButton.tap()
        XCTAssertTrue(app.staticTexts["0"].exists)
    }
    
    func testOpenCloseCircleMenu() {
        setupLoginandPassword(email: validEmail, password: validPassword)
        loginButton.tap()
        for _ in 0...5 {
            circleMenuButton.tap()
            circleMenuButton.tap()
        }
        
    }
    
    
    
    
    // MARK: Helpers
    
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
