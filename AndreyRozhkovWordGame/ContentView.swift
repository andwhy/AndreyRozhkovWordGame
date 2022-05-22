//
//  ContentView.swift
//  AndreyRozhkovWordGame
//
//  Created by an.rozhkov on 21.05.2022.
//

import SwiftUI

struct ContentView: View {
    
    @State var correctAttempts: UInt = 0
    @State var wrongAttempts: UInt = 0

    var body: some View {
        VStack {
            Group {
                HStack {
                    Spacer()
                    VStack(
                        alignment: .trailing,
                        spacing: 5.0
                    ){
                        Text("Correct attemps: \(correctAttempts)")
                            .font(.body)
                        Text("Wrong attemps: \(wrongAttempts)")
                            .font(.body)
                    }
                    .padding()
                }
            }
            Spacer()
            Group {
                VStack {
                    Text("This is a Spanish")
                        .font(.largeTitle)
                        .padding(.bottom, 1.0)
                    Text("This is English")
                        .font(.title3)
                }
            }
            Spacer()
            Group {
                HStack {
                    Spacer()
                    Button("Correct") {

                    }
                    Spacer()
                    Button("Wrong") {

                    }
                    Spacer()
                }
                .padding(.bottom, 50.0)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
