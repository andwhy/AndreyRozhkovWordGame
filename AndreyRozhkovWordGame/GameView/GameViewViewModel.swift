//
//  GameViewViewModel.swift
//  AndreyRozhkovWordGame
//
//  Created by an.rozhkov on 22.05.2022.
//

import Foundation
import Combine

class GameViewViewModel: ObservableObject {
    
    let maxWrongAttempts: UInt = 3
    let maxPairsIndex: UInt = 14

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
    @Published public var timerText: String = ""
    @Published public var gameDidEnd: Bool = false
    
    private let timer = TimerClient()
    
    public func correctSelected() {
        handlePairSelected(asCorrect: true)
    }
    
    public func wrongSelected() {
        handlePairSelected(asCorrect: false)
    }
    
    
    init(environment: GameViewViewModelEnvironment) {
        self.environment = environment
        
        listenForPairEvents()
        listenForTimerEvents()
    }
    
    private func listenForPairEvents() {
        environment.gamePairs
            .sink { [weak self] sequence in
                self?.gamePairs = sequence
            }
            .store(in: &cancellables)
        
        $gamePair.sink { [weak self] _ in
            self?.timer.start()
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
        checkForGameEnd()
        pushNextPair()
    }
    
    private func handleRoundTimeOut() {
        wrongAttempts += 1
        checkForGameEnd()
        pushNextPair()
    }
    
    private func checkForGameEnd() {
        if wrongAttempts >= maxWrongAttempts ||
         currentPairsIndex >= maxPairsIndex {
            gameDidEnd = true
        }
    }
    
    // MARK: Timer
    
    private func listenForTimerEvents() {
        timer.start()
        timer.timerText
            .receive(on: DispatchQueue.main)
            .sink { [weak self] text in
                self?.timerText = text
        }
        .store(in: &cancellables)
        
        timer.roundTimeDidEnd
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.handleRoundTimeOut()
        }
        .store(in: &cancellables)
    }
}

struct GameViewViewModelEnvironment {
    var gamePairs: AnyPublisher<[GameWordPair], Never>
    var refreshPairs: () -> Void
}
