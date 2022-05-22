//
//  TimerClient.swift
//  AndreyRozhkovWordGame
//
//  Created by an.rozhkov on 22.05.2022.
//

import Foundation
import Combine

class TimerClient: ObservableObject {
    
    private let timerTexts = ["00:05", "00:04", "00:03", "00:02", "00:01", "00:00"]
    private let maxTimerCounts = 6
    
    private lazy var timerTextSubject = CurrentValueSubject<String, Never>(timerTexts.first!)
    private var roundTimeDidEndSubject = PassthroughSubject<Void, Never>()
    
    public var timerText: AnyPublisher<String, Never> {
        timerTextSubject.eraseToAnyPublisher()
    }
    public var roundTimeDidEnd: AnyPublisher<Void, Never> {
        roundTimeDidEndSubject.eraseToAnyPublisher()
    }
    
    private var timer: Timer? {
        didSet {
            runCount = 0
        }
    }
    
    private var runCount = 0
    
    // MARK: Interface
    
    public func start() {
        stop()
        timer = Timer.scheduledTimer(
            timeInterval: 1.0,
            target: self,
            selector: #selector(timerFired),
            userInfo: nil,
            repeats: true
        )
        timer?.fire()
    }
    
    public func stop() {
        timer?.invalidate()
        timer = nil
    }
    
    @objc
    private func timerFired() {
        guard runCount < maxTimerCounts else {
            roundTimeDidEndSubject.send(())
            stop()
            return
        }
        
        sendTimerText(index: runCount)
        runCount += 1
    }
    
    private func sendTimerText(index: Int) {
        guard timerTexts.indices.contains(index) else {
            assertionFailure("TimerTextIndex out of range")
            return
        }
        timerTextSubject.send(timerTexts[index])
    }
    
}
