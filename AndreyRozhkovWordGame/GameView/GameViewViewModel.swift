//
//  GameViewViewModel.swift
//  AndreyRozhkovWordGame
//
//  Created by an.rozhkov on 22.05.2022.
//

import Foundation
import Combine

class GameViewViewModel: ObservableObject {

    private let environment: GameViewViewModelEnvironment
    private var cancellables = Set<AnyCancellable>()
    private var gamePairs: [GameWordPair] = [] {
        didSet {
            currentPairsIndex = 0
            gamePair = gamePairs[currentPairsIndex]
        }
    }
    private var currentPairsIndex = 0
    
    @Published public var gamePair: GameWordPair = GameWordPair(pair: WordPair(textEng: "", textSpa: ""), isCorrect: true)
    @Published public var correctAttempts: UInt = 0
    @Published public var wrongAttempts: UInt = 0
    
    public func correctSelected() {
        handlePairSelected(asCorrect: true)
        pushNextPair()
    }
    
    public func wrongSelected() {
        handlePairSelected(asCorrect: false)
        pushNextPair()
    }
    
    
    init(environment: GameViewViewModelEnvironment) {
        self.environment = environment
        
        listenForPairUpdates()
    }
    
    private func listenForPairUpdates() {
        environment.gamePairs
            .sink { sequence in
            self.gamePairs = sequence
        }
        .store(in: &cancellables)
    }
    
    private func pushNextPair() {
        guard currentPairsIndex < gamePairs.count - 1 else {
            environment.refreshPairs()
            return
        }
        currentPairsIndex += 1
        gamePair = gamePairs[currentPairsIndex]
    }
    
    private func handlePairSelected(asCorrect: Bool) {
        if gamePair.isCorrect == asCorrect {
            correctAttempts += 1
        } else {
            wrongAttempts += 1
        }
    }
}

struct GameViewViewModelEnvironment {
    var gamePairs: AnyPublisher<[GameWordPair], Never>
    var refreshPairs: () -> Void
}
