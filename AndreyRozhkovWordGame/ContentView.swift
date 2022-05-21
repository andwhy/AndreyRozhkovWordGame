//
//  ContentView.swift
//  AndreyRozhkovWordGame
//
//  Created by an.rozhkov on 21.05.2022.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        Text("Hello, world!")
            .padding()
            .onAppear {
                WordPairsClient.live(with: WordPairsClientEnvironment())
            }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
