//
//  WordPairsClient.swift
//  AndreyRozhkovWordGame
//
//  Created by an.rozhkov on 21.05.2022.
//

import Foundation

struct WordPairsClient {
        
    private let environment: WordPairsClientEnvironment

    init(environment: WordPairsClientEnvironment) {
        self.environment = environment
    }
        
    func getPairs() -> [WordPair]? {
        guard let jsonData = loadJson(fileName: environment.fileName, fileExtension: environment.fileExtension),
              let wordPairs = decodeData(jsonData, of: WordPair.self) else {
            return nil
        }
        return wordPairs
    }
    
    // MARK: Private
    
    private func loadJson(fileName: String, fileExtension: String) -> Data? {
        guard let url = Bundle.main.url(forResource: fileName, withExtension: fileExtension),
              let data = try? Data(contentsOf: url)
        else {
            return nil
        }
        return data
     }
        
    private func decodeData<T: Decodable>(_ data: Data, of model: T.Type) -> [T]? {
        let decoder = JSONDecoder()
        guard let models = try? decoder.decode([T].self, from: data) else {
            return nil
       }
       return models
    }
}
