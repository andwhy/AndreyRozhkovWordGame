//
//  GameViewViewModelEnvironment.swift
//  AndreyRozhkovWordGame
//
//  Created by an.rozhkov on 23.05.2022.
//

import Combine

struct GameViewViewModelEnvironment {
    var gamePairs: AnyPublisher<[GameWordPair], Never>
    var refreshPairs: () -> Void
}
