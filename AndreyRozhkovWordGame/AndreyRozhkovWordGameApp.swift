//
//  AndreyRozhkovWordGameApp.swift
//  AndreyRozhkovWordGame
//
//  Created by an.rozhkov on 21.05.2022.
//

import SwiftUI

@main
struct AndreyRozhkovWordGameApp: App {
    
    let router = ViewRouter()
    
    var body: some Scene {
        WindowGroup {
            router.buildView(route: .start)
        }
    }
}
