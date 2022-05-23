//
//  GameView.swift
//  AndreyRozhkovWordGame
//
//  Created by an.rozhkov on 21.05.2022.
//

import SwiftUI
import Combine

// TODO: Separate this view to smaller reusable views like AttemptsView

struct GameView: View {
        
    @EnvironmentObject var router: ViewRouterEnvironment
    
    @ObservedObject var model: GameViewViewModel
    @State private var timerColor = Color.gray
    
    var body: some View {
        NavigationView {
            VStack {
                AttemptsView(viewState: AttemptsViewState(
                    correctAttempts: model.correctAttempts,
                    wrongAttempts: model.wrongAttempts
                ))
                Spacer()
                Group {
                    VStack {
                        Text("\(model.gamePair.pair.textSpa.capitalized)")
                            .font(.largeTitle)
                            .lineLimit(3)
                            .padding(.bottom, 1.0)
                        Text("\(model.gamePair.pair.textEng.capitalized)")
                            .font(.title3)
                            .lineLimit(3)
                    }
                }
                
                Spacer()
                Group {
                    VStack {
                        Text(model.timerText)
                            .font(.title3)
                            .padding()
                            .background(timerColor)
                            .foregroundColor(.white)
                            .multilineTextAlignment(.center)
                            .clipShape(Capsule())
                            .padding(.bottom, 30)
                            .onReceive(model.$gamePair, perform: { _ in
                                timerColor = .gray
                                withAnimation(.easeInOut(duration: 5)) {
                                    timerColor = .red
                                }
                            })
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
                    }
                    .padding(.bottom, 50.0)
                }
            }
            .navigationBarBackButtonHidden(true)
            .navigationBarHidden(true)
        }
        .onChange(of: model.gameDidEnd, perform: { gameDidEnd in
            router.isPlaying = !gameDidEnd
        })
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
