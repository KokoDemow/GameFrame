//
//  InLevel.swift
//  TheGame
//
//  Created by Juergen Boiselle on 01.11.19.
//  Copyright © 2019 Juergen Boiselle. All rights reserved.
//

import SwiftUI
import GameFrameKit
import StoreKit

struct InLevelView<C, S>: View where C: GameConfig, S: Skin {
    @ObservedObject var gameUI = GameUI.instance
    @EnvironmentObject private var skin: S

    private struct GameView: View {
        let isOverlayed: Bool
        @State private var gameFrame: CGRect = .zero
        @State private var informationFrame: CGRect = .zero
        @State private var navigationFrame: CGRect = .zero
        @State private var sharedImage: UIImage?
        @EnvironmentObject private var config: C
        @EnvironmentObject private var skin: S
        @Environment(\.presentationMode) private var presentationMode
        
        var body: some View {
            ZStack {
                // Spread to available display
                VStack{Spacer(); HStack{Spacer()}}
                EmptyView()
                    .build(skin, .InLevel(.GameZone(
                        gameFrame,
                        informationFrame: informationFrame,
                        navigationFrame: navigationFrame)))
                InformationLayer<S>(
                    parent: "InLevel",
                    items: config.inLevelInformation(frame: gameFrame))
                    .build(skin, .InLevel(.Information))
                    .getFrame($informationFrame)
                NavigationLayer<C, S>(
                    parent: "InLevel",
                    items: config.inLevelNavigation(frame: gameFrame),
                    navbarItem: config.inLevelNavigationBar,
                    bounds: gameFrame,
                    isOverlayed: isOverlayed)
                    .build(skin, .InLevel(.Navigation))
                    .getFrame($navigationFrame)
            }
            .build(skin, .InLevel(.Game(isOverlayed: isOverlayed)))
            .getFrame($gameFrame)
            .onAppear {
                GameUI.instance.presentationMode = self.presentationMode
                if !self.isOverlayed {GameUI.instance.resume()}
            }
            .onDisappear {
                if !self.isOverlayed {GameUI.instance.pause()}
                GameUI.instance.presentationMode = nil
            }
        }
    }

    private struct OfferOverlay: View {
        let consumableId: String
        let rewardQuantity: Int
        @ObservedObject private var inApp = GameFrame.inApp
        
        private struct ProductRow: View {
            let product: SKProduct
            let isOverlayed: Bool
            @EnvironmentObject private var skin: S
            
            var body: some View {
                Button(action: {
                    GameFrame.inApp.buy(product: self.product, quantity: 1)
                }) {
                    HStack {
                        VStack {
                            Text("\(product.localizedTitle)")
                                .build(skin, .OfferProductTitle(id: product.productIdentifier))
                            Text("\(product.localizedDescription)")
                                .build(skin, .OfferProductDescription(id: product.productIdentifier))
                        }
                        Spacer()
                        VStack {
                            Image(systemName: "cart")
                                .build(skin, .OfferProductCart(id: product.productIdentifier))
                            Text("\(product.localizedPrice(quantity: 1))")
                                .build(skin, .OfferProductPrice(id: product.productIdentifier))
                        }
                    }
                }
                .disabled(isOverlayed)
                .buttonStyle(SkinButtonStyle(skin: skin, item: .OfferProduct(
                    id: product.productIdentifier,
                    isDisabled: isOverlayed)))
            }
        }
        
        private struct ProductsView: View {
            let consumableId: String
            let rewardQuantity: Int
            let isOverlayed: Bool
            @EnvironmentObject private var skin: S
            
            var body: some View {
                let products = GameFrame.inApp.getProducts(consumableIds: [consumableId], nonConsumableIds: [String]())
                
                return VStack {
                    ForEach(0..<products.count, id: \.self) {
                        ProductRow(product: products[$0], isOverlayed: self.isOverlayed)
                    }
                    .build(skin, .Offer(.Products))
                    NavigationLayer<C, S>(parent: "Offer",
                        items: [[
                            .Buttons(.OfferBack()),
                            .Buttons(.Reward(consumableId: consumableId, quantity: rewardQuantity))
                        ]],
                        isOverlayed: isOverlayed)
                        .build(skin, .Offer(.Navigation))
                }
                .build(skin, .Offer(.Main(isOverlayed: isOverlayed)))
                .onAppear {
                    guard !self.isOverlayed else {return}
                    
                    if !GameUI.instance.gameDelegate.keepOffer() {
                        GameUI.instance.clearOffer()
                    }
                }
            }
        }
        
        var body: some View {
            // TODO: Workaround as of XCode 11.2. When reading one published var of an ObservablObject multiple times, the App crashes
            ZStack {
                if inApp.purchasing {
                    ProductsView(
                        consumableId: consumableId,
                        rewardQuantity: rewardQuantity,
                        isOverlayed: true)
                    WaitAlert<S>()
                } else if inApp.error != nil {
                    ProductsView(
                        consumableId: consumableId,
                        rewardQuantity: rewardQuantity,
                        isOverlayed: true)
                    ErrorAlert<C, S>()
                } else {
                    ProductsView(
                        consumableId: consumableId,
                        rewardQuantity: rewardQuantity,
                        isOverlayed: false)
                }
            }
        }
    }

    var body: some View {
        // TODO: Workaround as of XCode 11.2. When reading one published var of an ObservablObject multiple times, the App crashes
        ZStack {
            if gameUI.offer != nil {
                GameView(isOverlayed: true)
                OfferOverlay(
                    consumableId: GameUI.instance!.offer!.consumableId,
                    rewardQuantity: GameUI.instance!.offer!.quantity)
            } else {
                GameView(isOverlayed: false)
            }
        }
        .build(skin, .InLevel(.Main))
    }
}

struct InLevel_Previews: PreviewProvider {
    static var previews: some View {
        InLevelView<PreviewConfig, PreviewSkin>()
        .environmentObject(PreviewConfig())
        .environmentObject(PreviewSkin())
    }
}
