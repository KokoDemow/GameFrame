//
//  TheGameConfig.swift
//  TheGame
//
//  Created by Juergen Boiselle on 18.11.19.
//  Copyright © 2019 Juergen Boiselle. All rights reserved.
//

import Foundation
import GameUIKit
import GameFrameKit
import SwiftUI

class TheGameConfig: GameConfig {
    let offLevelInformation: [[Information]] = [
        [
            .Achievement(id: "Medals", format: "%.1f"),
            .NonConsumable(id: "weaponB", opened: Image(systemName: "location"), closed: Image(systemName: "location.slash")),
            .NonConsumable(id: "weaponC", opened: Image(systemName: "location.fill"), closed: nil)
        ], [
            .Score(id: "Points"),
            .Consumable(id: "Bullets")
        ]]
    
    let offLevelNavigation: [[Navigation]] = [
        [
            .Links(.Store(consumableIds: ["Bullets"], nonConsumableIds: ["weaponB", "weaponC"])),
            .Buttons(.Reward(consumableId: "Bullets", quantity: 100))
        ], [
            .Buttons(.GameCenter()),
            .Buttons(.Share(greeting: "Hi! I'm playing The Game", format: "%.1f")),
            .Buttons(.Like(appId: "X")) // TODO: Replace with real value from AppStore
        ], [
            .Generics(.Url("https://www.apple.com")),
            .Links(.Settings())
        ], [
            .Links(.Play())
        ]
    ]
    
    let inLevelInformation: [[Information]] = [[
            .Score(id: "Points")
        ], [
            .Achievement(id: "Medals", format: "%.1f"),
            .Consumable(id: "Bullets")
        ]]
    
    let inLevelNavigation: [[Navigation]] = [
        [
            .Links(.Store(consumableIds: ["Bullets"], nonConsumableIds: ["weaponB", "weaponC"])),
            .Buttons(.Reward(consumableId: "Bullets", quantity: 100))
        ], [
            .Links(.Back())
        ]
    ]
    
    let settingsInformation: [[Information]] = [[
            .Achievement(id: "Medals", format: "%.1f"),
            .Consumable(id: "Bullets")
        ]]
    
    let settingsNavigation: [[Navigation]] = [
        [
            .Links(.Store(consumableIds: ["Bullets"], nonConsumableIds: ["weaponB", "weaponC"])),
            .Buttons(.Reward(consumableId: "Bullets", quantity: 100))
        ], [
            .Buttons(.SystemSettings()),
            .Links(.Back())
        ]
    ]

    let purchasables: [String: [GFInApp.Purchasable]] = [
        "bulletsS": [.Consumable(id: "Bullets", quantity: 200)],
        "bulletsM": [.Consumable(id: "Bullets", quantity: 1000)],
        "bulletsL": [.Consumable(id: "Bullets", quantity: 2000)],
        "Lives": [.Consumable(id: "Lives", quantity: 1)],
        "weaponB": [.NonConsumable(id: "weaponB")],
        "weaponC": [.NonConsumable(id: "weaponC")]]
    
    let adUnitIdBanner: String? = "ca-app-pub-3940256099942544/2934735716"
    let adUnitIdRewarded: String? = "ca-app-pub-3940256099942544/1712485313"
    let adUnitIdInterstitial: String? = "ca-app-pub-3940256099942544/4411468910"
    
    let adNonCosumableId: String? = "no-ads4"
}
