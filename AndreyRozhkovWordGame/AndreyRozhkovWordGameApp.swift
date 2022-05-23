//
//  AndreyRozhkovWordGameApp.swift
//  AndreyRozhkovWordGame
//
//  Created by an.rozhkov on 21.05.2022.
//

import SwiftUI

struct AndreyRozhkovWordGameApp: App {
    
    let router = ViewRouter()
    
    var body: some Scene {
        WindowGroup {
            router.buildView(route: .start)
        }
    }
}

@main
struct AppLauncher {

    static func main() throws {
        if NSClassFromString("XCTestCase") == nil {
            AndreyRozhkovWordGameApp.main()
        } else {
            TestApp.main()
        }
    }
}

struct TestApp: App {
    
    var body: some Scene {
        WindowGroup { Text("Running Unit Tests") }
    }
}
