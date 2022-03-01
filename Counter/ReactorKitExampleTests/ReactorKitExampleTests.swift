//
//  ReactorKitExampleTests.swift
//  ReactorKitExampleTests
//
//  Created by SEUNGMIN OH on 2022/03/02.
//

import XCTest
@testable import ReactorKitExample

class ReactorKitExampleTests: XCTestCase {
    
    var view: MainViewController!
    var reactor: MainViewReactor!

    override func setUpWithError() throws {
        view = MainViewController()
        reactor = MainViewReactor()
    }

    override func tearDownWithError() throws {
        view = nil
        reactor = nil
    }

    func testAction_whenDidTapIncreaseButtonInView_thenMutationIsIncreaseInReactore() throws {
        // Given
        reactor.isStubEnabled = true
        
        view.loadViewIfNeeded()
        view.reactor = reactor
        
        // When
        view.increaseButton.sendActions(for: .touchUpInside)
        
        // Then
        XCTAssertEqual(reactor.stub.actions.last, .increase)
    }
    
    func testAction_whenDidTapDecreaseButtonInView_thenMutationIsDecreaseInReactore() throws {
        // Given
        reactor.isStubEnabled = true
        
        view.loadViewIfNeeded()
        view.reactor = reactor
        
        // When
        view.decreaseButton.sendActions(for: .touchUpInside)
        
        // Then
        XCTAssertEqual(reactor.stub.actions.last, .decrease)
    }
    
    func testState_whenChangeLoadingStateInReactor_thenActivityIndicatorIsAnimatingInView() throws {
        // Given
        reactor.isStubEnabled = true
        
        view.loadViewIfNeeded()
        view.reactor = reactor
        
        // When
        reactor.stub.state.value = MainViewReactor.State(value: 0, isLoading: true)
        
        // Then
        XCTAssertEqual(view.activityIndicatorView.isAnimating, true)
    }
    
    func testReactor_whenExecuteIncreaseButtonTapInView_thenStateInLoadingInReactor() throws {
        // When
        XCTAssertEqual(reactor.currentState.isLoading, false)
        
        reactor.action.onNext(.decrease)
        
        // Then
        XCTAssertEqual(reactor.currentState.isLoading, true)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
