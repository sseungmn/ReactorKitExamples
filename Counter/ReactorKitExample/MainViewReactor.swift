//
//  MainViewReactor.swift
//  ReactorKitExample
//
//  Created by SEUNGMIN OH on 2022/03/02.
//

import Foundation
import ReactorKit

class MainViewReactor: Reactor {
    enum Action {
        case increase
        case decrease
    }
    
    enum Mutation {
        case increaseValue
        case decreaseValue
        case setLoading(Bool)
    }
    
    struct State {
        var value: Int = 0
        var isLoading: Bool = false
    }
    
    let initialState = State()
    
    func mutate(action: MainViewReactor.Action) -> Observable<MainViewReactor.Mutation> {
        print("mutate")
        switch action {
        case .increase:
            return Observable.concat([
                Observable.just(Mutation.setLoading(true)),
                Observable.just(Mutation.increaseValue).delay(.seconds(1), scheduler: MainScheduler.instance),
                Observable.just(Mutation.setLoading(false)),
            ])
        case .decrease:
            return Observable.concat([
                Observable.just(Mutation.setLoading(true)),
                Observable.just(Mutation.decreaseValue).delay(.seconds(1), scheduler: MainScheduler.instance),
                Observable.just(Mutation.setLoading(false)),
            ])
        }
    }
    
    func reduce(state: MainViewReactor.State, mutation: MainViewReactor.Mutation) -> State {
        print("reduce")
        var newState = state
        switch mutation {
        case .increaseValue:
            newState.value += 1
        case .decreaseValue:
            newState.value -= 1
        case .setLoading(let isLoading):
            newState.isLoading = isLoading
            print("isLoading : ", isLoading)
        }
        return newState
    }
}
