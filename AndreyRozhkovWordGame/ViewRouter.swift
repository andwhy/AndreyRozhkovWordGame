//
//  ViewRouter.swift
//  AndreyRozhkovWordGame
//
//  Created by an.rozhkov on 22.05.2022.
//

import Foundation
import SwiftUI

struct ViewRouter {
    
    public enum Routes {
        case game
        case start
    }
    
    private let wordPairClient = WordPairsClient.live() // TODO: Inject it via environment or property
    private let viewRouterEnvironment = ViewRouterEnvironment()
    
    func buildView(route: ViewRouter.Routes) -> AnyView {
        switch route {
        case .game:
            let environment = GameViewViewModelEnvironment(
                gamePairs: wordPairClient.pairSequence,
                refreshPairs: wordPairClient.refreshSequence
            )
            return AnyView(GameView(model: GameViewViewModel(environment: environment))
                .environmentObject(viewRouterEnvironment))
        case .start:
            return AnyView(StartView(model: StartViewModel(startGame: { buildView(route: .game) }))
                .environmentObject(viewRouterEnvironment))
        }
    }
}


