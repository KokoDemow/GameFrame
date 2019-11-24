//
//  TheGameSkin.swift
//  TheGame
//
//  Created by Juergen Boiselle on 13.11.19.
//  Copyright © 2019 Juergen Boiselle. All rights reserved.
//

import SwiftUI
import GameFrameKit
import GameUIKit

// MARK: The GameZone View
struct TheGameZoneModifier: ViewModifier {
    func body(content: Content) -> some View {TheGameView().background(Color.yellow)}
}

struct TheGameSettingsModifier: ViewModifier {
    func body(content: Content) -> some View {TheGameSettingsView().background(Color.yellow)}
}

struct TheGameNavigationItemModifier: ButtonStyle {
    var parent: String
    var isDisabled: Bool
    var row: Int
    var col: Int

    func makeBody(configuration: Self.Configuration) -> some View {
        VStack {
            if parent == "OffLevel" && row == 0 && col == 0 {
                GeometryReader {
                    proxy in
                    
                    if proxy.size.width < proxy.size.height {
                        VStack {
                            Spacer()
                            Text("The Game!").font(.largeTitle)
                            Image(systemName: "play.circle")
                                .resizable().scaledToFit()
                                .foregroundColor(self.isDisabled ? Color.secondary : Color.accentColor)
                            Spacer()
                        }
                    } else {
                        HStack {
                            Spacer()
                            Text("The Game!").font(.largeTitle)
                            Image(systemName: "play.circle")
                                .resizable().scaledToFit()
                                .foregroundColor(self.isDisabled ? Color.secondary : Color.accentColor)
                            Spacer()
                        }
                    }
                }
            } else {
                configuration.label
                    .foregroundColor(isDisabled ? Color.secondary : Color.accentColor)
                    .padding()
            }
        }
    }
}

// MARK: - A Skin that delegates to standard skin implementation
class TheGameSkin: GameSkin {
    func getInLevelGameZoneModifier() -> some ViewModifier {TheGameZoneModifier()}
    
    func getSettingsSpaceModifier() -> some ViewModifier {TheGameSettingsModifier()}

    func getNavigationItemModifier(parent: String, isDisabled: Bool, row: Int, col: Int) -> some ButtonStyle {
         TheGameNavigationItemModifier(parent: parent, isDisabled: isDisabled, row: row, col: col)
    }
}
