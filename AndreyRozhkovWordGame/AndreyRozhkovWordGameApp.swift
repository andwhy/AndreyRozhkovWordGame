//
//  AndreyRozhkovWordGameApp.swift
//  AndreyRozhkovWordGame
//
//  Created by an.rozhkov on 21.05.2022.
//

import SwiftUI

@main
struct AndreyRozhkovWordGameApp: App {
    var body: some Scene {
        WindowGroup {
            let wordPairClient = WordPairsClient.live()
            GameView(model:
                        GameViewViewModel(environment:
                                            GameViewViewModelEnvironment(
                                                gamePairs: wordPairClient.pairSequence,
                                                refreshPairs: wordPairClient.refreshSequence
                                            )
                                         )
            )
        }
    }
}
