// aetherTests/Features/Login/Presentation/Interactor/LoginInteractorTests.swift

import XCTest
@testable import aether

final class LoginInteractorTests: XCTestCase {

    private func makeSUT() -> (sut: LoginInteractor, useCase: LoginUseCaseSpy, presenter: LoginPresenterSpy) {
        let useCase = LoginUseCaseSpy()
        let presenter = LoginPresenterSpy()
        let sut = LoginInteractor(loginUseCase: useCase, presenter: presenter)
        return (sut, useCase, presenter)
    }

    func test_login_withEmptyEmail_presentsValidationFailure_andDoesNotCallUseCase() {
        let (sut, useCase, presenter) = makeSUT()

        sut.login(request: Login.Request(email: "", password: "Abcdef1!"))

        XCTAssertEqual(presenter.failureError as? Login.ValidationError, .emptyEmail)
        XCTAssertEqual(useCase.executeCallCount, 0)
    }

    func test_login_withInvalidEmailFormat_presentsValidationFailure() {
        let (sut, useCase, presenter) = makeSUT()

        sut.login(request: Login.Request(email: "not-an-email", password: "Abcdef1!"))

        XCTAssertEqual(presenter.failureError as? Login.ValidationError, .invalidEmailFormat)
        XCTAssertEqual(useCase.executeCallCount, 0)
    }

    func test_login_withEmptyPassword_presentsValidationFailure() {
        let (sut, useCase, presenter) = makeSUT()

        sut.login(request: Login.Request(email: "user@aether.com", password: ""))

        XCTAssertEqual(presenter.failureError as? Login.ValidationError, .emptyPassword)
        XCTAssertEqual(useCase.executeCallCount, 0)
    }

    func test_login_withPasswordMissingNumber_presentsNoNumberPasswordFailure() {
        let (sut, useCase, presenter) = makeSUT()

        sut.login(request: Login.Request(email: "user@aether.com", password: "Abcdefg!"))

        XCTAssertEqual(presenter.failureError as? Login.ValidationError, .noNumberPassword)
        XCTAssertEqual(useCase.executeCallCount, 0)
    }

    func test_login_withPasswordMissingSpecialCharacter_presentsNoSpecialCharacterPasswordFailure() {
        let (sut, useCase, presenter) = makeSUT()

        sut.login(request: Login.Request(email: "user@aether.com", password: "Abcdefg1"))

        XCTAssertEqual(presenter.failureError as? Login.ValidationError, .noSpecialCharacterPassword)
        XCTAssertEqual(useCase.executeCallCount, 0)
    }

    func test_login_withShortPassword_presentsShortPasswordFailure() {
        let (sut, useCase, presenter) = makeSUT()

        sut.login(request: Login.Request(email: "user@aether.com", password: "A1@bc"))

        XCTAssertEqual(presenter.failureError as? Login.ValidationError, .shortPassword)
        XCTAssertEqual(useCase.executeCallCount, 0)
    }
}
