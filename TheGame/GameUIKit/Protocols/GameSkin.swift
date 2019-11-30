//
//  Skin.swift
//  TheGame
//
//  Created by Juergen Boiselle on 12.11.19.
//  Copyright © 2019 Juergen Boiselle. All rights reserved.
//

import SwiftUI
import GameFrameKit

// MARK: - Extensionsa and Views
/**
 Specialized form of `ViewModifier` for `Image`´s
 */
public protocol ImageModifier {
    associatedtype Body: View
    
    func body(image: Image) -> Self.Body
}

public extension Image {
    /**
     Specialized version of `View.modifier()` for Image fields. The modifier must be an `ImageModifier`.
     */
    func modifier<T>(_ modifier: T) -> some View where T: ImageModifier {modifier.body(image: self)}
}

/**
 Specialized form of `ViewModifier` for `Text`´s
 */
public protocol TextModifier {
    associatedtype Body: View
    
    func body(text: Text) -> Self.Body
}

public extension Text {
    /**
     Specialized version of `View.modifier()` for Text fields. The modifier must be a `TextModifier`.
     */
    func modifier<T>(_ modifier: T) -> some View where T: TextModifier {modifier.body(text: self)}
}

// MARK: - Modifier Implementations for Identity Skin
struct MainBannerModifier: ViewModifier {
    let width: CGFloat
    let height: CGFloat
    
    func body(content: Content) -> some View {content}
}

struct MainBannerEmptyModifier: ViewModifier {
    func body(content: Content) -> some View {
        Text("Thank you for playing The Game")
    }
}

struct OffLevelModifier: ViewModifier {
    func body(content: Content) -> some View {content.padding()}
}

struct OffLevelNavigationModifier: ViewModifier {
    func body(content: Content) -> some View {content}
}

struct OffLevelInformationModifier: ViewModifier {
    func body(content: Content) -> some View {content}
}

struct InLevelModifier: ViewModifier {
    func body(content: Content) -> some View {content}
}

struct InLevelGameModifier: ViewModifier {
    let isOverlayed: Bool
    
    func body(content: Content) -> some View {
        content.padding().blur(radius: isOverlayed ? 5.0 : 0.0)
    }
}

struct InLevelNavigationModifier: ViewModifier {
    func body(content: Content) -> some View {content}
}

struct InLevelInformationModifier: ViewModifier {
    func body(content: Content) -> some View {content}
}

struct SettingsModifier: ViewModifier {
    func body(content: Content) -> some View {content.padding()}
}

struct SettingsNavigationModifier: ViewModifier {
    func body(content: Content) -> some View {content}
}

struct SettingsInformationModifier: ViewModifier {
    func body(content: Content) -> some View {content}
}

struct StoreModifier: ViewModifier {
    func body(content: Content) -> some View {content}
}

struct StoreEmptyModifier: TextModifier {
    func body(text: Text) -> some View {text}
}

struct StoreNavigationModifier: ViewModifier {
    func body(content: Content) -> some View {content}
}

struct StoreProductsModifier: ViewModifier {
    let isOverlayed: Bool
    
    func body(content: Content) -> some View {
        content.padding().blur(radius: isOverlayed ? 5.0 : 0.0)
    }
}

struct StoreProductModifier: ViewModifier {
    let id: String

    func body(content: Content) -> some View {
        content.padding(.vertical, nil)
    }
}

struct StoreProductButtonModifier: ButtonStyle {
    let id: String
    let isDisabled: Bool
    
    func makeBody(configuration: Self.Configuration) -> some View {
        return configuration.label
            .foregroundColor(isDisabled ? Color.secondary : Color.accentColor)
    }
}

struct StoreProductTitleModifier: TextModifier {
    let id: String
    
    func body(text: Text) -> some View {text}
}

struct StoreProductDescriptionModifier: TextModifier {
    let id: String
    
    func body(text: Text) -> some View {text}
}

struct StoreProductQuantityModifier: TextModifier {
    let id: String
    
    func body(text: Text) -> some View {text}
}

struct StoreProductStepperModifier: ButtonStyle {
    let id: String
    let isDisabled: Bool

    func makeBody(configuration: Self.Configuration) -> some View {
        return configuration.label
            .foregroundColor(isDisabled ? Color.secondary : Color.accentColor)
    }
}

struct StoreProductCartModifier: ImageModifier {
    let id: String
    
    func body(image: Image) -> some View {image}
}

struct StoreProductPriceModifier: TextModifier {
    let id: String
    
    func body(text: Text) -> some View {text}
}

struct OfferModifier: ViewModifier {
    let isOverlayed: Bool
    
    func body(content: Content) -> some View {
        content
        .padding()
        .background(Color.secondary.colorInvert())
        .blur(radius: isOverlayed ? 5.0 : 0.0)
    }
}

struct OfferNavigationModifier: ViewModifier {
    func body(content: Content) -> some View {content}
}

struct OfferProductsModifier: ViewModifier {
    func body(content: Content) -> some View {content}
}

struct OfferProductModifier: ButtonStyle {
    let id: String
    let isDisabled: Bool

   func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label.foregroundColor(isDisabled ? Color.secondary : Color.accentColor)
    }
}

struct OfferProductTitleModifier: TextModifier {
    let id: String

    func body(text: Text) -> some View {text}
}

struct OfferProductDescriptionModifier: TextModifier {
    let id: String

    func body(text: Text) -> some View {text}
}

struct OfferProductCartModifier: ImageModifier {
    let id: String

    func body(image: Image) -> some View {image}
}

struct OfferProductPriceModifier: TextModifier {
    let id: String

    func body(text: Text) -> some View {text}
}

struct InformationItemModifier: TextModifier {
    let parent: String
    let id: String

    func body(text: Text) -> some View {text}
}

struct InformationNonConsumableModifier: ViewModifier {
    let parent: String
    let id: String

    func body(content: Content) -> some View {content}
}

struct InformationRowModifier: ViewModifier {
    let parent: String
    let row: Int

    func body(content: Content) -> some View {content}
}

struct NavigationItemModifier: ButtonStyle {
    let parent: String
    let isDisabled: Bool
    let item: Navigation

    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .foregroundColor(isDisabled ? Color.secondary : Color.accentColor)
            .padding()
    }
}

struct NavigationRowModifier: ViewModifier {
    let parent: String
    let row: Int

    func body(content: Content) -> some View {content}
}

struct WaitModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
        .padding()
    }
}

struct ErrorMessageModifier: TextModifier {
    func body(text: Text) -> some View {text}
}

struct ErrorModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .background(Color.secondary.colorInvert())
    }
}

/**
 Define the look of your Game. Implement the protocol and override the given `extensions`as necessary.
 To implement a change in look for a particular item:
 1. Override function to get the `View/Text/ImageModifier` or `ButtonStyle`
 2. Write your own modifier and call it in the overridden function
 */
public protocol GameSkin: ObservableObject {
    associatedtype MainBannerModifierType: ViewModifier
    associatedtype MainBannerEmptyModifierType: ViewModifier
    associatedtype OffLevelModifierType: ViewModifier
    associatedtype OffLevelNavigationModifierType: ViewModifier
    associatedtype OffLevelInformationModifierType: ViewModifier
    associatedtype InLevelModifierType: ViewModifier
    associatedtype InLevelGameModifierType: ViewModifier
    associatedtype InLevelNavigationModifierType: ViewModifier
    associatedtype InLevelInformationModifierType: ViewModifier
    associatedtype InLevelGameZoneModifierType: ViewModifier
    associatedtype SettingsModifierType: ViewModifier
    associatedtype SettingsSpaceModifierType: ViewModifier
    associatedtype SettingsNavigationModifierType: ViewModifier
    associatedtype SettingsInformationModifierType: ViewModifier
    associatedtype StoreModifierType: ViewModifier
    associatedtype StoreEmptyModifierType: TextModifier
    associatedtype StoreNavigationModifierType: ViewModifier
    associatedtype StoreProductsModifierType: ViewModifier
    associatedtype StoreProductModifierType: ViewModifier
    associatedtype StoreProductButtonModifierType: ButtonStyle
    associatedtype StoreProductTitleModifierType: TextModifier
    associatedtype StoreProductDescriptionModifierType: TextModifier
    associatedtype StoreProductQuantityModifierType: TextModifier
    associatedtype StoreProductStepperModifierType: ButtonStyle
    associatedtype StoreProductCartModifierType: ImageModifier
    associatedtype StoreProductPriceModifierType: TextModifier
    associatedtype OfferModifierType: ViewModifier
    associatedtype OfferNavigationModifierType: ViewModifier
    associatedtype OfferProductsModifierType: ViewModifier
    associatedtype OfferProductModifierType: ButtonStyle
    associatedtype OfferProductTitleModifierType: TextModifier
    associatedtype OfferProductDescriptionModifierType: TextModifier
    associatedtype OfferProductCartModifierType: ImageModifier
    associatedtype OfferProductPriceModifierType: TextModifier
    associatedtype InformationItemModifierType: TextModifier
    associatedtype InformationNonConsumableModifierType: ViewModifier
    associatedtype InformationRowModifierType: ViewModifier
    associatedtype NavigationItemModifierType: ButtonStyle
    associatedtype NavigationRowModifierType: ViewModifier
    associatedtype WaitModifierType: ViewModifier
    associatedtype ErrorMessageModifierType: TextModifier
    associatedtype ErrorModifierType: ViewModifier
    
    func getMainBannerModifier(width: CGFloat, height: CGFloat) -> MainBannerModifierType
    func getMainBannerEmptyModifier() -> MainBannerEmptyModifierType
    func getOffLevelModifier() -> OffLevelModifierType
    func getOffLevelNavigationModifier() -> OffLevelNavigationModifierType
    func getOffLevelInformationModifier() -> OffLevelInformationModifierType
    func getInLevelModifier() -> InLevelModifierType
    func getInLevelGameModifier(isOverlayed: Bool) -> InLevelGameModifierType
    func getInLevelNavigationModifier() -> InLevelNavigationModifierType
    func getInLevelInformationModifier() -> InLevelInformationModifierType
    func getInLevelGameZoneModifier(_ selfFrame: CGRect, informationFrame: CGRect, navigationFrame: CGRect) -> InLevelGameZoneModifierType
    func getSettingsModifier() -> SettingsModifierType
    func getSettingsSpaceModifier(_ selfFrame: CGRect, informationFrame: CGRect, navigationFrame: CGRect) -> SettingsSpaceModifierType
    func getSettingsNavigationModifier() -> SettingsNavigationModifierType
    func getSettingsInformationModifier() -> SettingsInformationModifierType
    func getStoreModifier() -> StoreModifierType
    func getStoreEmptyModifier() -> StoreEmptyModifierType
    func getStoreNavigationModifier() -> StoreNavigationModifierType
    func getStoreProductsModifier(isOverlayed: Bool) -> StoreProductsModifierType
    func getStoreProductModifier(id: String) -> StoreProductModifierType
    func getStoreProductButtonModifier(id: String, isDisabled: Bool) -> StoreProductButtonModifierType
    func getStoreProductTitleModifier(id: String) -> StoreProductTitleModifierType
    func getStoreProductDescriptionModifier(id: String) -> StoreProductDescriptionModifierType
    func getStoreProductQuantityModifier(id: String) -> StoreProductQuantityModifierType
    func getStoreProductStepperModifier(id: String, isDisabled: Bool) -> StoreProductStepperModifierType
    func getStoreProductCartModifier(id: String) -> StoreProductCartModifierType
    func getStoreProductPriceModifier(id: String) -> StoreProductPriceModifierType
    func getOfferModifier(isOverlayed: Bool) -> OfferModifierType
    func getOfferNavigationModifier() -> OfferNavigationModifierType
    func getOfferProductsModifier() -> OfferProductsModifierType
    func getOfferProductModifier(id: String, isDisabled: Bool) -> OfferProductModifierType
    func getOfferProductTitleModifier(id: String) -> OfferProductTitleModifierType
    func getOfferProductDescriptionModifier(id: String) -> OfferProductDescriptionModifierType
    func getOfferProductCartModifier(id: String) -> OfferProductCartModifierType
    func getOfferProductPriceModifier(id: String) -> OfferProductPriceModifierType
    func getInformationItemModifier(parent: String, id: String) -> InformationItemModifierType
    func getInformationNonConsumableModifier(parent: String, id: String) -> InformationNonConsumableModifierType
    func getInformationRowModifier(parent: String, row: Int) -> InformationRowModifierType
    func getNavigationItemModifier(parent: String, isDisabled: Bool, item: Navigation) -> NavigationItemModifierType
    func getNavigationRowModifier(parent: String, row: Int) -> NavigationRowModifierType
    func getWaitModifier() -> WaitModifierType
    func getErrorMessageModifier() -> ErrorMessageModifierType
    func getErrorModifier() -> ErrorModifierType
}

public extension GameSkin {
      func getMainBannerModifier(width: CGFloat, height: CGFloat) -> some ViewModifier {
          MainBannerModifier(width: width, height: height)
     }
      func getMainBannerEmptyModifier() -> some ViewModifier {
          MainBannerEmptyModifier()
     }
      func getOffLevelModifier() -> some ViewModifier {
          OffLevelModifier()
     }
      func getOffLevelNavigationModifier() -> some ViewModifier {
          OffLevelNavigationModifier()
     }
      func getOffLevelInformationModifier() -> some ViewModifier {
          OffLevelInformationModifier()
     }
    func getInLevelModifier() -> some ViewModifier {
        InLevelModifier()
     }
      func getInLevelGameModifier(isOverlayed: Bool) -> some ViewModifier {
          InLevelGameModifier(isOverlayed: isOverlayed)
       }
      func getInLevelNavigationModifier() -> some ViewModifier {
          InLevelNavigationModifier()
     }
      func getInLevelInformationModifier() -> some ViewModifier {
          InLevelInformationModifier()
     }
      func getSettingsModifier() -> some ViewModifier {
          SettingsModifier()
     }
      func getSettingsNavigationModifier() -> some ViewModifier {
          SettingsNavigationModifier()
     }
      func getSettingsInformationModifier() -> some ViewModifier {
          SettingsInformationModifier()
     }
     func getStoreModifier() -> some ViewModifier {
         StoreModifier()
    }
     func getStoreEmptyModifier() -> some TextModifier {
         StoreEmptyModifier()
    }
     func getStoreNavigationModifier() -> some ViewModifier {
         StoreNavigationModifier()
    }
     func getStoreProductsModifier(isOverlayed: Bool) -> some ViewModifier {
         StoreProductsModifier(isOverlayed: isOverlayed)
    }
      func getStoreProductModifier(id: String) -> some ViewModifier {
          StoreProductModifier(id: id)
     }
      func getStoreProductButtonModifier(id: String, isDisabled: Bool) -> some ButtonStyle {
          StoreProductButtonModifier(id: id, isDisabled: isDisabled)
     }
    func getStoreProductTitleModifier(id: String) -> some TextModifier {
        StoreProductTitleModifier(id: id)
    }
     func getStoreProductDescriptionModifier(id: String) -> some TextModifier {
         StoreProductDescriptionModifier(id: id)
    }
     func getStoreProductQuantityModifier(id: String) -> some TextModifier {
         StoreProductQuantityModifier(id: id)
    }
     func getStoreProductStepperModifier(id: String, isDisabled: Bool) -> some ButtonStyle {
        StoreProductStepperModifier(id: id, isDisabled: isDisabled)
    }
     func getStoreProductCartModifier(id: String) -> some ImageModifier {
         StoreProductCartModifier(id: id)
    }
     func getStoreProductPriceModifier(id: String) -> some TextModifier {
         StoreProductPriceModifier(id: id)
    }
      func getOfferModifier(isOverlayed: Bool) -> some ViewModifier {
        OfferModifier(isOverlayed: isOverlayed)
    }
     func getOfferNavigationModifier() -> some ViewModifier {
         OfferNavigationModifier()
    }
     func getOfferProductsModifier() -> some ViewModifier {
         OfferProductsModifier()
    }
     func getOfferProductModifier(id: String, isDisabled: Bool) -> some ButtonStyle {
         OfferProductModifier(id: id, isDisabled: isDisabled)
    }
     func getOfferProductTitleModifier(id: String) -> some TextModifier {
         OfferProductTitleModifier(id: id)
    }
     func getOfferProductDescriptionModifier(id: String) -> some TextModifier {
         OfferProductDescriptionModifier(id: id)
    }
     func getOfferProductCartModifier(id: String) -> some ImageModifier {
         OfferProductCartModifier(id: id)
    }
     func getOfferProductPriceModifier(id: String) -> some TextModifier {
         OfferProductPriceModifier(id: id)
    }
     func getInformationItemModifier(parent: String, id: String) -> some TextModifier {
         InformationItemModifier(parent: parent, id: id)
    }
      func getInformationNonConsumableModifier(parent: String, id: String) -> some ViewModifier {
          InformationNonConsumableModifier(parent: parent, id: id)
     }
      func getInformationRowModifier(parent: String, row: Int) -> some ViewModifier {
          InformationRowModifier(parent: parent, row: row)
     }
    func getNavigationItemModifier(parent: String, isDisabled: Bool, item: Navigation) -> some ButtonStyle {
         NavigationItemModifier(parent: parent, isDisabled: isDisabled, item: item)
    }
      func getNavigationRowModifier(parent: String, row: Int) -> some ViewModifier {
          NavigationRowModifier(parent: parent, row: row)
     }
     func getWaitModifier() -> some ViewModifier {
         WaitModifier()
    }
     func getErrorMessageModifier() -> some TextModifier {
         ErrorMessageModifier()
    }
     func getErrorModifier() -> some ViewModifier {
         ErrorModifier()
    }
}

// MARK: - Skin implementation for previews
struct PreviewModifier: ViewModifier {
    func body(content: Content) -> some View {content}
}

// MARK: - A Skin that delegates to standard skin implementation
class PreviewSkin: GameSkin {
    func getInLevelGameZoneModifier(_ selfFrame: CGRect, informationFrame: CGRect, navigationFrame: CGRect)
        -> some ViewModifier
    {
        PreviewModifier()
    }
    func getSettingsSpaceModifier(_ selfFrame: CGRect, informationFrame: CGRect, navigationFrame: CGRect)
        -> some ViewModifier
    {
        PreviewModifier()
    }
}

