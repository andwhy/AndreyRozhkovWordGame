//
//  GameView.swift
//  AndreyRozhkovWordGame
//
//  Created by an.rozhkov on 21.05.2022.
//

import SwiftUI
import Combine

struct GameView: View {
    
    @ObservedObject var model: GameViewViewModel
    
    var body: some View {
        VStack {
            Group {
                HStack {
                    Spacer()
                    VStack(
                        alignment: .trailing,
                        spacing: 5.0
                    ){
                        Text("Correct attemps: \(model.correctAttempts)")
                            .font(.body)
                        Text("Wrong attemps: \(model.wrongAttempts)")
                            .font(.body)
                    }
                    .padding()
                }
            }
            Spacer()
            Group {
                VStack {
                    Text("\(model.gamePair.pair.textSpa.capitalized)")
                        .font(.largeTitle)
                        .padding(.bottom, 1.0)
                    Text("\(model.gamePair.pair.textEng.capitalized)")
                        .font(.title3)
                }
            }
            Spacer()
            Group {
                HStack {
                    Spacer()
                    Button("Correct") {
                        model.correctSelected()
                    }
                    .buttonStyle(GrowingButton())
                    Spacer()
                    Button("Wrong") {
                        model.wrongSelected()
                    }
                    .buttonStyle(GrowingButton())
                    Spacer()
                }
                .padding(.bottom, 50.0)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let wordPairClient = WordPairsClient.live()
        GameView(model:
                    GameViewViewModel(environment:
                                        GameViewViewModelEnvironment(
                                            gamePairs: wordPairClient.pairSequence,
                                            refreshPairs: wordPairClient.refreshSequence
                                        )
                                     )
        )
    }
}

struct GrowingButton: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .background(.blue)
            .foregroundColor(.white)
            .clipShape(Capsule())
            .scaleEffect(configuration.isPressed ? 1.2 : 1)
            .animation(.easeOut(duration: 0.2), value: configuration.isPressed)
    }
}
