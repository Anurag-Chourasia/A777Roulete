//
//  SlotMachineModel.swift
//  A777SlotMachine
//
//  Created by Anurag Chourasia on 14/02/25.
//


import SwiftUI

class SlotMachineModel: ObservableObject {
    @Published var offset: CGFloat = -1040
    let symbols = ["🍒", "🍋", "🍊", "7️⃣", "🍉", "⭐️", "💎", "🍇", "🍌", "🔔"]
    let symbolHeightWithPadding: CGFloat = 80
    let probability: Double = 1.0 / pow(Double(10), 3) // 0.1%
}
