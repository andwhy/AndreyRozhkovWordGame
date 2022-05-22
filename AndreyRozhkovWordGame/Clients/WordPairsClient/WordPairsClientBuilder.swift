//
//  WordPairsClientBuilder.swift
//  AndreyRozhkovWordGame
//
//  Created by an.rozhkov on 21.05.2022.
//

import Foundation

extension WordPairsClient {
    static func live(
    ) -> WordPairsClient {
        WordPairsClient(environment: WordPairsClientEnvironment())
    }
}
