//
//  AndreyRozhkovWordGameTests.swift
//  AndreyRozhkovWordGameTests
//
//  Created by an.rozhkov on 21.05.2022.
//

import XCTest
import Combine

class AndreyRozhkovWordGameTests: XCTestCase {

    let pairSequenseLentght = 15
    let correctPairsRate = 0.25
    
    let wordPairClient = WordPairsClient.live()
    let expectation = XCTestExpectation()
    var cancellables = Set<AnyCancellable>()
    
    func testWordPairsLoading() {
        wordPairClient.pairSequence.sink { [weak self] pairs in
            XCTAssertFalse(pairs.isEmpty)
            XCTAssert(self?.pairSequenseLentght == pairs.count)
            self?.expectation.fulfill()
        }
        .store(in: &cancellables)
    
        wait(for: [expectation], timeout: 5)
    }
    
    func testCorrectPairsDistribution() {
        let expectedNumberOfCorrectPairs = Int(round((Double(pairSequenseLentght) * correctPairsRate)))
        
        wordPairClient.pairSequence.sink { [weak self] pairs in
            XCTAssert(self?.pairSequenseLentght == pairs.count)

            let correctPairsNumber = pairs.filter { $0.isCorrect }.count
            XCTAssertEqual(expectedNumberOfCorrectPairs, correctPairsNumber)
            self?.expectation.fulfill()
        }
        .store(in: &cancellables)
    
        wait(for: [expectation], timeout: 5)
    }
}
