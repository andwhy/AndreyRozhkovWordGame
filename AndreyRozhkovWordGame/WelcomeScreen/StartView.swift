//
//  StartView.swift
//  AndreyRozhkovWordGame
//
//  Created by an.rozhkov on 22.05.2022.
//

import SwiftUI

struct StartView: View {
    
    var model: StartViewModel

    @EnvironmentObject var router: ViewRouterEnvironment
    
    var body: some View {
        NavigationView {
            VStack {
                Button("Start") {
                    router.isPlaying.toggle()
                }
                .buttonStyle(GrowingButton())

                NavigationLink("", isActive: $router.isPlaying) {
                    model.startGame()
                        .navigationBarBackButtonHidden(true)
                        .navigationBarHidden(true)
                }
                .isDetailLink(false)
            }
        }
    }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        StartView(model: StartViewModel(startGame: { AnyView(EmptyView()) }))
    }
}
