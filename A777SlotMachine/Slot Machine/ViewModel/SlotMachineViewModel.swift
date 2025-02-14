//
//  SlotMachineViewModel.swift
//  A777SlotMachine
//
//  Created by Anurag Chourasia on 14/02/25.
//

import SwiftUI

class SlotMachineViewModel: ObservableObject {
    @Published var slot1 = "7️⃣"
    @Published var slot2 = "7️⃣"
    @Published var slot3 = "7️⃣"
    @Published var isSpinning = false
    @Published var showWinMessage = false
    @Published var wonAmount: Int = 0
    @Published var totalEarning: Int = 0
    @Published var offsets: (slot1: CGFloat, slot2: CGFloat, slot3: CGFloat) = (slot1: -1040, slot2: -1040, slot3: -1040)
    @Published var spinTapCount: Int = 0
    @Published var animationRequired: Bool = true
    
    let model = SlotMachineModel()
    
    func spinSlots() {
        isSpinning = true
        for i in 0..<3 {
            let randomStops = Int.random(in: 0..<model.symbols.count*100)
            let finalPosition = CGFloat(randomStops) * (-model.symbolHeightWithPadding)
            
            DispatchQueue.main.async {
                withAnimation(Animation.easeOut(duration: (self.animationRequired ? 3 : 0))) {
                    switch i {
                    case 0:
                        self.offsets.slot1 = finalPosition
                    case 1:
                        self.offsets.slot2 = finalPosition
                    case 2:
                        self.offsets.slot3 = finalPosition
                    default:
                        break
                    }
                }
            }
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + (animationRequired ? 3 : 0)) {
            self.isSpinning = false
            self.slot1 = self.model.symbols[abs(Int(self.offsets.slot1 / self.model.symbolHeightWithPadding) % self.model.symbols.count)]
            self.slot2 = self.model.symbols[abs(Int(self.offsets.slot2 / self.model.symbolHeightWithPadding) % self.model.symbols.count)]
            self.slot3 = self.model.symbols[abs(Int(self.offsets.slot3 / self.model.symbolHeightWithPadding) % self.model.symbols.count)]
            self.checkWinningCombination()
            self.spinTapCount += 1
        }
    }
    
    func resetSlots() {
        DispatchQueue.main.async {
            withAnimation(Animation.easeOut(duration: (self.animationRequired ? 1 : 0))) {
                let offset = -(self.model.symbolHeightWithPadding * 13)
                self.offsets = (slot1: offset, slot2: offset, slot3: offset)
                self.totalEarning = 0
                self.showWinMessage = false
                self.wonAmount = 0
                self.spinTapCount = 0
            }
        }
    }
    
    func checkWinningCombination() {
        // Check for winning combination and update wonAmount and totalEarning
        if slot1 == slot2 && slot2 == slot3 {
            wonAmount = (slot1 == "7️⃣" ? 10_000 : 1000)
        } else if slot1 == slot3 && slot2 != slot3 {
            wonAmount = (slot1 == "7️⃣" ? 500 : 50)
        } else if (slot1 == slot2 && slot1 != slot3) || (slot2 == slot3 && slot1 != slot2) {
            wonAmount = (slot1 == "7️⃣" ? 1_000 : 100)
        }
        showWinMessage = true
        totalEarning += wonAmount
    }
}
