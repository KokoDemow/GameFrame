//
//  InLevel.swift
//  TheGame
//
//  Created by Juergen Boiselle on 01.11.19.
//  Copyright © 2019 Juergen Boiselle. All rights reserved.
//

import SwiftUI
import GameFrameKit
import Combine

struct InLevel: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject private var inApp = GameFrame.inApp
    @ObservedObject private var adMob = GameFrame.adMob
    @ObservedObject private var controller = gameZoneController

    @State private var showStore = false

    var body: some View {
        ZStack {
            GameZone()
            VStack {
                NavigationLink(destination: StoreView(
                        consumableIds: ["Bullets"],
                        nonConsumableIds: ["weaponB", "weaponC"]),
                    isActive: $showStore) {EmptyView()}

                InformationArea(
                    scoreIds: ["Points"],
                    achievements: [(id:"Medals", format: "%.1f")],
                    consumableIds: ["Bullets"],
                    nonConsumables: [])
                
                Spacer()
                
                NavigationArea(navigatables: [
                    (action: {self.showStore.set()},
                     image: Image(systemName: "cart"),
                     disabled: !inApp.available),
                    (action: {
                        gameZoneController.pause()
                        GameFrame.adMob.showReward(
                            consumable: GameFrame.coreData.getConsumable("Bullets"),
                            quantity: 100,
                            completionHandler: {gameZoneController.resume()})
                    },
                     image: Image(systemName: "film"),
                     disabled: !adMob.rewardAvailable),
                    (action: {gameZoneController.leaveLevel()},
                     image: Image(systemName: "xmark"),
                     disabled: nil)])
            }
        }
        .overlay(VStack {
            if controller.offer != nil {
                OfferOverlay(
                    consumableId: controller.offer!.consumableId,
                    rewardQuantity: controller.offer!.quantity,
                    completionHandler: {self.controller.clearOffer()})
            } else {
                EmptyView()
            }
        })
        .overlay(WaitWithErrorOverlay(completionHandler: {self.controller.clearOffer()}))
        .onReceive(self.controller.objectWillChange, perform: {
            _ in
            log(self.controller.isInLevel, self.controller.offer, self.controller.isResumed)
            if !self.controller.isInLevel {self.presentationMode.wrappedValue.dismiss()}
        })
        .onAppear(perform: {self.controller.resume()})
        .onDisappear(perform: {self.controller.pause()})
        .modifier(NavigatableViewModifier())
    }
}

struct InLevel_Previews: PreviewProvider {
    static var previews: some View {
        InLevel()
    }
}

let gameZoneController = GameZoneController()

protocol GameZoneDelegate {
    func pause()
    func resume()
    func enterLevel()
    func leaveLevel() -> (requestReview: Bool, showInterstitial: Bool)
}

class GameZoneController: NSObject, ObservableObject {
    fileprivate override init(){}
    
    private var delegate: GameZoneDelegate? = nil
    func setDelegate(delegate: GameZoneDelegate) {self.delegate = delegate}
    
    @Published fileprivate private(set) var offer: (consumableId: String, quantity: Int)? = nil
    @Published fileprivate private(set) var isInLevel: Bool = false
    @Published fileprivate private(set) var isResumed: Bool = false
    
    /**
     Called by your game to let `InLevel`show an offer to the player. This will first pause the game by calling `pause()` in the `TheGameDelegate`, then show the offering. When offering dissappears, `resume()` is called and the consumables might reflect the new values - if the player decided to take the offer. If player decided to not
     take the offer, the consumables and therefore conditions to show the offer, might still be in place.
     */
    func makeOffer(consumableId: String, quantity: Int) {
        log(delegate != nil, consumableId, quantity)
        pause()
        offer = (consumableId: consumableId, quantity: quantity)
    }
    
    /**
     Called by your game, when the game has ended or the current level is over. Should be the last call after a the optional last offer and a possible "GameOver" animation.
     */
    func leaveLevel() {
        log(delegate != nil, isInLevel)
        if let leave = delegate?.leaveLevel() {
            GameFrame.instance.leaveLevel(requestReview: leave.requestReview, showInterstitial: leave.showInterstitial)
        } else {
            GameFrame.instance.leaveLevel(requestReview: false, showInterstitial: false)
        }
        isInLevel = false
    }
    
    /**
     Called by your game when entering a new level. Should be the first call before any animation happens but after delegate is set.
     */
    func enterLevel() {
        log(delegate != nil, isInLevel)
        delegate?.enterLevel()
        GameFrame.instance.enterLevel()
        isInLevel = true
    }
    
    /**
     Called internally to clear offer and let it dissappear.
     */
    fileprivate func clearOffer() {
        log(offer)
        offer = nil
        resume()
    }
    
    fileprivate func pause() {
        if isResumed {
            isResumed = false
            delegate?.pause()
        }
    }
    
    fileprivate func resume() {
        if !isResumed {
            isResumed = true
            delegate?.resume()
        }
    }
}
