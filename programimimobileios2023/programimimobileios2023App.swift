//
//  programimimobileios2023App.swift
//  programimimobileios2023
//
//  Created by Dreni Mujaj on 20.9.23.
//

import SwiftUI

@main
struct programimimobileios2023App: App {
    @StateObject private var playerData = PlayerData()
    var body: some Scene {
        WindowGroup {
            PlayerInputView().environmentObject(playerData) 
        }
    }
}
