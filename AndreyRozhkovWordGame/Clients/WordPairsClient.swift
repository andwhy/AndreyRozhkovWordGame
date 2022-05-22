//
//  WordPairsClient.swift
//  AndreyRozhkovWordGame
//
//  Created by an.rozhkov on 21.05.2022.
//

import Foundation
import Combine

class WordPairsClient: ObservableObject {
    
    //MARK: Constants
    
    let pairSequenseLentght = 15
    let correctPairsRate = 0.25

    //MARK: Properties
    
    private let environment: WordPairsClientEnvironment
    
    private lazy var wordPairs = { () -> [WordPair] in
        let jsonData = loadJson(fileName: environment.fileName, fileExtension: environment.fileExtension)
        let wordPairs = decodeData(jsonData, of: WordPair.self)
        return wordPairs
    }()
    
    private var correctWordPair: WordPair {
        let randIndex = getRandomIndexIn(pairSequenseLentght)
        return wordPairs[randIndex]
    }
    
    private var incorrectWordPair: WordPair {
        let randIndex = getRandomIndexIn(pairSequenseLentght)
        let randIndexOfIncorrectPair = getRandomIndexIn(pairSequenseLentght, excludeIndex: randIndex)

        return WordPair(
            textEng: wordPairs[randIndex].textSpa,
            textSpa: wordPairs[randIndexOfIncorrectPair].textEng
        )
    }
    
    private var pairSubject = CurrentValueSubject<[GameWordPair], Never>([])
    
    // MARK: Interface
    
    public func refreshSequence() {
        pairSubject.send(getGamePairSequence(lenght: pairSequenseLentght))
    }
    
    public var pairSequence: AnyPublisher<[GameWordPair], Never> {
        pairSubject.eraseToAnyPublisher()
    }
    
    init(environment: WordPairsClientEnvironment) {
        self.environment = environment
        
        refreshSequence()
    }
    
    //MARK: Game Word Pairs Generating
    
    func getGamePairSequence(lenght: Int) -> [GameWordPair] {
        let numberOfCorrectPairs = Int(Double(lenght) * correctPairsRate)
        let numberOfIncorrectPairs = lenght - Int(numberOfCorrectPairs)
        
        let correctPairs = (0..<numberOfCorrectPairs)
            .map { _ in correctWordPair }
            .map { GameWordPair(pair: $0, isCorrect: true) }
        
        let incorrectPairs = (0..<numberOfIncorrectPairs)
            .map { _ in incorrectWordPair }
            .map { GameWordPair(pair: $0, isCorrect: false) }

        return (correctPairs + incorrectPairs).shuffled()
    }
        
    // MARK: Data loading & decoding
    
    private func loadJson(fileName: String, fileExtension: String) -> Data {
        guard let url = Bundle.main.url(forResource: fileName, withExtension: fileExtension),
              let data = try? Data(contentsOf: url)
        else {
            fatalError("Can't load json")
        }
        return data
     }
        
    private func decodeData<T: Decodable>(_ data: Data, of model: T.Type) -> [T] {
        let decoder = JSONDecoder()
        guard let models = try? decoder.decode([T].self, from: data) else {
            fatalError("Can't decode data")
       }
       return models
    }
    
    // MARK: Random generation
    
    private func getRandomIndexIn(_ lenght: Int,  excludeIndex: Int? = nil) -> Int {
        let randIndex = Int.random(in: 0..<lenght)
        
        if let excludeIndex = excludeIndex {
            return randIndex == excludeIndex ?
            getRandomIndexIn(lenght, excludeIndex: excludeIndex) : randIndex
        } else {
            return randIndex
        }
    }
}
