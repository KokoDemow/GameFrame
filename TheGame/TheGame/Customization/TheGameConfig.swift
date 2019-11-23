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
    let offLevelInformation: [[InformationItem]] = [
        [
            .AchievementItem(id: "Medals", format: "%.1f"),
            .NonConsumableItem(id: "weaponB", opened: Image(systemName: "location"), closed: Image(systemName: "location.slash")),
            .NonConsumableItem(id: "weaponC", opened: Image(systemName: "location.fill"), closed: nil)
        ], [
            .ScoreItem(id: "Points"),
            .ConsumableItem(id: "Bullets")
        ]]
    
    let offLevelNavigation: [[NavigationItem]] = [[
            .PlayLink()
        ], [
            .StoreLink(consumableIds: ["Bullets"], nonConsumableIds: ["weaponB", "weaponC"]),
            .RewardLink(consumableId: "Bullets", quantity: 100)
        ], [
            .GameCenterLink(),
            .ShareLink(greeting: "Hi! I'm playing The Game", format: "%.1f"),
            .LikeLink(appId: "X") // TODO: Replace with real value from AppStore
        ], [
            .UrlLink(urlString: "https://www.apple.com"),
            .SettingsLink()
        ]]
    
    let inLevelInformation: [[InformationItem]] = [[
            InformationItem.ScoreItem(id: "Points")
        ], [
            .AchievementItem(id: "Medals", format: "%.1f"),
            .ConsumableItem(id: "Bullets")
        ]]
    
    let inLevelNavigation: [[NavigationItem]] = [[
            .StoreLink(consumableIds: ["Bullets"], nonConsumableIds: ["weaponB", "weaponC"]),
            .RewardLink(consumableId: "Bullets", quantity: 100)
        ], [
            .BackLink()
        ]]

    let purchasables: [String: [GFInApp.Purchasable]] = [
        "bulletsS": [.Consumable(id: "Bullets", quantity: 200)],
        "bulletsM": [.Consumable(id: "Bullets", quantity: 1000)],
        "bulletsL": [.Consumable(id: "Bullets", quantity: 2000)],
        "Lives": [.Consumable(id: "Lives", quantity: 1)],
        "weaponB": [.NonConsumable(id: "weaponB")],
        "weaponC": [.NonConsumable(id: "weaponC")]]
    
    let adUnitIdBanner = "ca-app-pub-3940256099942544/2934735716"
    let adUnitIdRewarded = "ca-app-pub-3940256099942544/1712485313"
    let adUnitIdInterstitial = "ca-app-pub-3940256099942544/4411468910"
}
