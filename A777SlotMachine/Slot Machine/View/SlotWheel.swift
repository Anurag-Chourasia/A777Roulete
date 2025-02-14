//
//  SlotWheel.swift
//  A777SlotMachine
//
//  Created by Anurag Chourasia on 14/02/25.
//

import SwiftUI

struct SlotWheel: View {
    @Binding var offset: CGFloat
    let symbols: [String]
    let symbolHeightWithPadding: CGFloat
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                ForEach(0..<symbols.count*100, id: \.self) { index in
                    Text(symbols[index % symbols.count])
                        .font(.largeTitle)
                        .padding(.horizontal, 15)
                        .frame(width: geometry.size.width, height: symbolHeightWithPadding)
                        .offset(y: offset + (CGFloat(index) * symbolHeightWithPadding))
                }
            }
            .frame(width: geometry.size.width, height: (symbolHeightWithPadding * 2.5))
            .clipped()
            .background(Color.gray.opacity(0.25))
            .overlay(
                VStack(spacing:0) {
                    LinearGradient(gradient: Gradient(colors: [.black.opacity(1.0), .black.opacity(0.5), .black.opacity(0.05)]),
                                   startPoint: .top,
                                   endPoint: .bottom)
                    .frame(height: symbolHeightWithPadding*0.75)
                    Spacer()
                    LinearGradient(gradient: Gradient(colors: [.black.opacity(0.05), .black.opacity(0.5), .black.opacity(1.0)]),
                                   startPoint: .top,
                                   endPoint: .bottom)
                    .frame(height: symbolHeightWithPadding*0.75)
                }
            )
        }
        .frame(width: symbolHeightWithPadding*1.2, height: (symbolHeightWithPadding * 2.5))
    }
}



//MARK: - Types of previews you can create

struct SlotWheel_Previews: PreviewProvider {
    static let symbols = ["🍒", "🍋", "🍊", "7️⃣", "🍉", "⭐️", "💎", "🍇", "🍌", "🔔"]
    static let symbolHeightWithPadding: CGFloat = 80
    static let offset: CGFloat = -1040
    static var previews: some View {
        SlotWheel(offset: .constant(offset),
                  symbols: symbols,
                  symbolHeightWithPadding: symbolHeightWithPadding)
        .cornerRadius(topLeft: symbolHeightWithPadding*1.2, topRight: 20, bottomLeft: symbolHeightWithPadding*1.2, bottomRight: 20)

    }
}
//
//struct SlotWheelMockDataStruct_Previews: PreviewProvider {
//    struct MockData {
//        let symbols = ["🍒", "🍋", "🍊", "7️⃣", "🍉", "⭐️", "💎", "🍇", "🍌", "🔔"]
//        let symbolHeightWithPadding: CGFloat = 80
//        let offset: CGFloat = -1040
//    }
//    
//    static var previews: some View {
//        let mockData = MockData()
//        return SlotWheel(
//            offset: .constant(mockData.offset),
//            symbols: mockData.symbols,
//            symbolHeightWithPadding: mockData.symbolHeightWithPadding
//        ).cornerRadius(topLeft: 20, topRight: 20, bottomLeft: 20, bottomRight: 20)
//
//    }
//}
//
//struct SlotWheelStructView_Previews: PreviewProvider {
//    
//    static var previews: some View {
//        
//        struct SlotWheelContainer {
//            @State var offset: CGFloat
//            let symbols: [String]
//            let symbolHeightWithPadding: CGFloat
//            
//            var slotWheelView: some View {
//                SlotWheel(offset: $offset,
//                          symbols: symbols,
//                          symbolHeightWithPadding: symbolHeightWithPadding)
//                .cornerRadius(topLeft: 20, topRight: 20, bottomLeft: 20, bottomRight: 20)
//            }
//        }
//        
//        let slotWheelData = SlotWheelContainer(offset: -1040,
//                                               symbols: ["🍒", "🍋", "🍊", "7️⃣", "🍉", "⭐️", "💎", "🍇", "🍌", "🔔"],
//                                               symbolHeightWithPadding: 80)
//        
//        return slotWheelData.slotWheelView
//    }
//}
