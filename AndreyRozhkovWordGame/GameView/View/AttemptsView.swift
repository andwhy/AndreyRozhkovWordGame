//
//  TimerView.swift
//  AndreyRozhkovWordGame
//
//  Created by an.rozhkov on 23.05.2022.
//

import SwiftUI

struct AttemptsView: View {
    
    var viewState: AttemptsViewState
    
    var body: some View {
        Group {
            HStack {
                Spacer()
                VStack(alignment: .center, spacing: 10) {
                    Text("Correct attemps: \(viewState.correctAttempts)")
                        .font(.title3)
                        .padding()
                        .foregroundColor(.white)
                        .background(.green)
                        .clipShape(Capsule())
                    Text("Wrong attemps: \(viewState.wrongAttempts)")
                        .font(.title3)
                        .padding()
                        .foregroundColor(.white)
                        .background(.red)
                        .clipShape(Capsule())
                }
                .padding()
            }
        }
    }
}

struct AttemptsViewState {
    let correctAttempts: UInt
    let wrongAttempts: UInt
}
