//
//  RelaxJediApp.swift
//  RelaxJedi
//
//  Created by Alexandre Bomfim on 01/12/22.
//

import SwiftUI

@main
struct RelaxJediApp: App {
    @AppStorage("FirstA") private var fA = false
    var body: some Scene {
        WindowGroup {
            if fA {
                ContentView()
            } else {
                HelpPlay()
            }
        }
    }
}
