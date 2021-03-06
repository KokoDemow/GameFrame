//
//  NavigationBar.swift
//  GameUIKit
//
//  Created by Juergen Boiselle on 11.12.19.
//  Copyright © 2019 Juergen Boiselle. All rights reserved.
//

import SwiftUI

struct NavigationBar<C, S>: View where C: GameConfig, S: Skin {
    let parent: String
    let title: String
    let item1: Navigation?
    let item2: Navigation?
    let isOverlayed: Bool
    let bounds: CGRect?
    @EnvironmentObject private var config: C
    @EnvironmentObject private var skin: S
    
    init(parent: String,
         title: String,
         item1: Navigation?,
         item2: Navigation? = nil,
         bounds: CGRect? = nil,
         isOverlayed: Bool = false)
    {
        self.parent = parent
        self.title = title
        self.item1 = item1
        self.item2 = item2
        self.bounds = bounds
        self.isOverlayed = isOverlayed
    }

    var body: some View {
        ZStack {
            HStack {
                Spacer()
                Text(title).build(skin, .NavigationBarTitle(parent: parent))
                Spacer()
            }
            HStack {
                if GameUI.instance.navigator.canGoBack() {
                    NavigationItem<C, S>(
                        parent: parent,
                        item: .Links(.Back(prevTitle: GameUI.instance.navigator.prevTitle())),
                        isOverlayed: isOverlayed,
                        bounds: bounds,
                        gameFrameId: "\(parent)-0")
                }
                Spacer()
                if item1 != nil {
                    NavigationItem<C, S>(
                        parent: parent, item: item1!,
                        isOverlayed: isOverlayed, bounds: bounds,
                        gameFrameId: "\(parent)-1")
                }
                if item2 != nil {
                    NavigationItem<C, S>(
                        parent: parent, item: item2!,
                        isOverlayed: isOverlayed, bounds: bounds,
                        gameFrameId: "\(parent)-2")
                }
            }
        }
        .build(skin, .Commons(.NavigationBar(parent: parent)))
    }
}

struct NavigationBar_Previews: PreviewProvider {
    static var previews: some View {
        NavigationBar<PreviewConfig, PreviewSkin>(
        parent: "Preview",
        title: "Title",
        item1: .Generics(.Url("https://www.apple.com")),
        item2: .Generics(.Url("https://www.google.com")),
        isOverlayed: false)
        .environmentObject(PreviewSkin())
        .environmentObject(PreviewConfig())
    }
}
