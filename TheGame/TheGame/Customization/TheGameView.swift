//
//  GameZone.swift
//  TheGame
//
//  Created by Juergen Boiselle on 09.11.19.
//  Copyright © 2019 Juergen Boiselle. All rights reserved.
//

import SwiftUI
import GameFrameKit
import GameUIKit

struct TheGameView: View {
    @ObservedObject private var points = GameFrame.coreData.getScore("Points")
    @ObservedObject private var medals = GameFrame.coreData.getAchievement("Medals")
    @ObservedObject private var bullets = GameFrame.coreData.getConsumable("Bullets")
    @ObservedObject private var lives = GameFrame.coreData.getConsumable("Lives")

    var body: some View {
        VStack {
            Spacer()
            HStack {
                Spacer()
                Button(action: {
                    GameFrame.audio.play("GrandOpening")
                    self.bullets.consume(1)
                    if self.bullets.available <= 0 {
                        self.makeOfferOrDie(consumableId: "Bullets", quantity: 100)
                    }
                }) {
                    Text("Shot")
                }
                Spacer()
                Button(action: {
                    self.points.earn(10)
                }) {
                    Text("Hit")
                }
                Spacer()
            }
            Spacer()
            HStack {
                Spacer()
                Button(action: {
                    self.medals.achieved(self.medals.current + 1)
                }) {
                    Text("Cool Move")
                }
                Spacer()
                Button(action: {
                    self.lives.consume(1)
                    if self.lives.available <= 0 {
                        self.makeOfferOrDie(consumableId: "Lives", quantity: 1)
                    }
                }) {
                    Text("Killed")
                }
                Spacer()
            }
            Spacer()
            Button(action: {
                GameFrame.coreData.getNonConsumable("no-ads4").unlock()
            }) {
                Text("Bought no-ads: \(GameFrame.coreData.getNonConsumable("no-ads4").isOpened ? "YES":"NO")")
            }
        }
    }
    
    // Make an offer to player, if points are in range. If not, die directly
    private func makeOfferOrDie(consumableId: String, quantity: Int) {
        let range = 0.8*Double(points.highest)..<Double(points.highest)
        
        if !range.contains(Double(points.current)) {
            GameUI.instance.gameOver()
        } else if !GameUI.instance.makeOffer(consumableId: consumableId, quantity: quantity) {
            GameUI.instance.gameOver()
        }
    }
}

struct TheGameView_Previews: PreviewProvider {
    static var previews: some View {
        TheGameView()
    }
}
