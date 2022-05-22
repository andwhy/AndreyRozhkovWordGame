//
//  StartViewModel.swift
//  AndreyRozhkovWordGame
//
//  Created by an.rozhkov on 22.05.2022.
//

import Foundation
import SwiftUI

struct StartViewModel {
    
    let startGame: () -> AnyView
    
    init(startGame: @escaping () -> AnyView) {
        self.startGame = startGame
    }
}
