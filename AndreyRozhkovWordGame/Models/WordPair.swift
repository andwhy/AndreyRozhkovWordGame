//
//  WordPair.swift
//  AndreyRozhkovWordGame
//
//  Created by an.rozhkov on 21.05.2022.
//

import Foundation

struct WordPair: Decodable {
    let textEng: String
    let textSpa: String
    
    private enum CodingKeys : String, CodingKey {
        case textEng = "text_eng"
        case textSpa = "text_spa"
    }
}
