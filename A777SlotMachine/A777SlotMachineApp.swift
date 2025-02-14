//
//  A777SlotMachineApp.swift
//  A777SlotMachine
//
//  Created by Anurag Chourasia on 14/02/25.
//

import SwiftUI

@main
struct A777SlotMachineApp: App {
    @AppStorage("isDarkMode") private var isDarkMode: Bool = false
    var body: some Scene {
        WindowGroup {
            SlotMachineView()
                .preferredColorScheme(isDarkMode ? .dark : .light)
                .dynamicTypeSize(...DynamicTypeSize.xxxLarge)
        }
    }
}

struct A777SlotMachineApp_Previews: PreviewProvider {
    static var previews: some View {
        SlotMachineView()
            .dynamicTypeSize(...DynamicTypeSize.xxxLarge)
            .previewInterfaceOrientation(.portrait)
    }
}
