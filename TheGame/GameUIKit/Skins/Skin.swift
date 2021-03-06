//
//  Skin.swift
//  GameUIKit
//
//  Created by Juergen Boiselle on 07.12.19.
//  Copyright © 2019 Juergen Boiselle. All rights reserved.
//

import SwiftUI
import GameFrameKit

// MARK: Skin items
/**
 Items to differentiate which part of thelook of the game will be changed by a modifier.
 */
public enum SkinItem {
    case View(_ item: SkinItemView)
    case Text(_ item: SkinItemText)
    case Image(_ item: SkinItemImage)
    case Button(_ item: SkinItemButton)
    case Toggle(_ item: SkinItemToggle)
    
    /// All views to be modified
    public enum SkinItemView {
        case Main(_ item: SkinItemMain)
        case OffLevel(_ item: SkinItemOffLevel)
        case InLevel(_ item: SkinItemInLevel)
        case Settings(_ item: SkinItemSettings)
        case Store(_ item: SkinItemStore)
        case Offer(_ item: SkinItemOffer)
        case Commons(_ item: SkinItemCommons)
        
        /// Modifiers for Main-View
        public enum SkinItemMain {
            case Main(current: Int)
            case Banner(width: CGFloat, height: CGFloat)
        }
        
        /// Modifiers for OffLevel-View
        public enum SkinItemOffLevel {
            case Main
        }
        
        /// Modifiers for InLevel-View
        public enum SkinItemInLevel {
            case Main
            case Game(isOverlayed: Bool)
            case GameZone(_ gameFrame: CGRect, informationFrame: CGRect, navigationFrame: CGRect)
        }
        
        /// Modifiers for Settings-View
        public enum SkinItemSettings {
            case Main
            case Space(_ gameFrame: CGRect, informationFrame: CGRect, navigationFrame: CGRect)
        }
        
        /// Modifiers for Store-View
        public enum SkinItemStore {
            case Main
            case Products(isOverlayed: Bool)
            case Product(id: String)
        }
        
        /// Modifiers for Offer-Overlay
        public enum SkinItemOffer {
            case Main
            case Products(isOverlayed: Bool)
        }
        
        /// Modifiers for any other view and overlay
        public enum SkinItemCommons {
            case Information(parent: String)
            case InformationItem(parent: String, id: String, current: Double)
            case InformationRow(parent: String, row: Int)
            case InformationNonConsumable(parent: String, id: String, isOpened: Bool)
            case NavigationLayer(parent: String)
            case NavigationBar(parent: String)
            case NavigationRow(parent: String, row: Int)
            case Wait
            case Error
        }
    }
    
    /// Modifiers for text in all views
    public enum SkinItemText {
        case StoreEmpty
        case StoreProductTitle(id: String)
        case StoreProductDescription(id: String)
        case StoreProductQuantity(id: String)
        case StoreProductPrice(id: String)
        case OfferProductTitle(id: String)
        case OfferProductDescription(id: String)
        case OfferProductPrice(id: String)
        case ErrorMessage
        case NavigationBarTitle(parent: String)
    }
    
    /// Modifiers for images in all views
    public enum SkinItemImage {
        case StoreProductCart(id: String)
        case OfferProductCart(id: String)
    }
    
    /// Modifiers for buttons in all views
    public enum SkinItemButton {
        case StoreProductButton(id: String, isDisabled: Bool)
        case StoreProductStepper(id: String, isDisabled: Bool)
        case OfferProduct(id: String, isDisabled: Bool)
        case NavigationItem(parent: String, isDisabled: Bool, item: Navigation)
    }
    
    /// Modifiers for toggles in all views
    public enum SkinItemToggle {
        case SettingsAudio
    }
}

// MARK: Definiton of Skin
/**
 Define the look of your Game. Implement the protocol and override the given `extensions`as necessary.
 
 Suggestion is, to start with one of the skin implementation first and add functionality to them.
 To implement a change in look for a particular item:
 1. Override function to get the `View/Text/ImageModifier` or `ButtonStyle`
 2. Write your own modifier and return it in the overridden function
 */
public protocol Skin: ObservableObject {
    func build<V>(_ item: SkinItem.SkinItemView, view: V) -> AnyView where V: View
    func build(_ item: SkinItem.SkinItemText, text: Text) -> AnyView
    func build(_ item: SkinItem.SkinItemImage, image: Image) -> AnyView
    func build<V>(_ item: SkinItem.SkinItemButton, label: V, isPressed: Bool) -> AnyView where V: View
    func build<V>(_ item: SkinItem.SkinItemToggle, label: V, isOn: Binding<Bool>) -> AnyView where V: View
}

struct SkinButtonStyle<S>: ButtonStyle where S: Skin {
    let skin: S
    let frameId: String
    let item: SkinItem.SkinItemButton
    
    func makeBody(configuration: Self.Configuration) -> some View {
        if configuration.isPressed {
            if let frame = GameUI.instance.storedFrames[frameId] {
                GameUI.instance.triggerPoint = frame.mid
            }
        }
        return skin.build(item, label: configuration.label, isPressed: configuration.isPressed)
    }
}

struct SkinToggleStyle<S>: ToggleStyle where S: Skin {
    let skin: S
    let item: SkinItem.SkinItemToggle
    
    func makeBody(configuration: Self.Configuration) -> some View {
        return skin.build(item, label: configuration.label, isOn: configuration.$isOn)
    }
}

extension View {
    func build<S>(_ skin: S, _ item: SkinItem.SkinItemView) -> some View  where S: Skin {
        skin.build(item, view: self)
    }
    
    /// Play a sound, that is registrered with the give key
    func play(_ key: String?, mix: GFAudio.Mix = .overlay) -> some View {
        if let key = key {GameFrame.audio.play(key, mix: mix)}
        return self
    }
}
extension Text {
    func build<S>(_ skin: S, _ item: SkinItem.SkinItemText) -> some View  where S: Skin {
        skin.build(item, text: self)
    }
}
extension Image {
    func build<S>(_ skin: S, _ item: SkinItem.SkinItemImage) -> some View  where S: Skin {
        skin.build(item, image: self)
    }
}
