//
//  SlotMachineView.swift
//  A777SlotMachine
//
//  Created by Anurag Chourasia on 14/02/25.
//

import SwiftUI

struct SlotMachineView: View {
    @StateObject private var viewModel = SlotMachineViewModel()
    @AppStorage("isDarkMode") private var isDarkMode: Bool = false
    
    // Dark mode enable toggle switch
        private var darkModeEnableToggle: some View {
            Button(action: {
                isDarkMode.toggle()
            }){
                Image(systemName: isDarkMode ? "moon.circle" : "sun.max.circle")
                    .resizable()
                    .frame(width: 30, height: 30)
                    .padding(10)
                    .foregroundStyle(Color("TextColor"))
            }
        }
    
    // Variable for slot machine title
    private var title: some View {
        Text("Slot Machine")
            .font(.largeTitle)
            .fontWeight(.bold)
            .foregroundStyle(Color("TextColor"))
    }
    
    // Variable for slot machine title
    private var moreButton: some View {
        NavigationLink(destination: KnowYourDeveloperView()) {
            Image(systemName: "info.circle")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(height: 30)
                .padding(10)
                .foregroundStyle(Color("TextColor"))
        }
    }

    
    // Variable for slot machine spin tap count
    private var spinTapCount: some View {
        Text("Count : \(viewModel.spinTapCount)")
            .font(.headline)
            .fontWeight(.bold)
    }
    
    // Variable for slot machine animation required
    private var animationRequired: some View {
        Toggle(isOn: $viewModel.animationRequired){
            Text("Animation is \(viewModel.animationRequired ? "On" : "Off")")
        }
        .aspectRatio(contentMode: .fit)
        .toggleStyle(.button)
        .foregroundStyle(Color.purple)
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color.black.opacity(0.2), lineWidth: 1)
        )
        
    }
    
    // Variable for probability text
    private var probabilityText: some View {
        Text("Try your Luck,\nProbability of getting 777 : \(viewModel.model.probability * 100, specifier: "%.1f")%")
            .font(.headline)
            .multilineTextAlignment(.center)
    }
    
    // Variable for slot wheels
    private var slotWheels: some View {
        ZStack{
            HStack(spacing: 2) {
                SlotWheel(offset: $viewModel.offsets.slot1,
                          symbols: viewModel.model.symbols,
                          symbolHeightWithPadding: viewModel.model.symbolHeightWithPadding)
                .cornerRadius(topLeft: 30, topRight: 0, bottomLeft: 30, bottomRight: 0)

                SlotWheel(offset: $viewModel.offsets.slot2,
                          symbols: viewModel.model.symbols,
                          symbolHeightWithPadding: viewModel.model.symbolHeightWithPadding)
                
                SlotWheel(offset: $viewModel.offsets.slot3,
                          symbols: viewModel.model.symbols,
                          symbolHeightWithPadding: viewModel.model.symbolHeightWithPadding)
                .cornerRadius(topLeft: 0, topRight: 30, bottomLeft: 0, bottomRight: 30)
            }
            .background{
                Color.white.opacity(0.0)
                    .frame(height: 80)
                    .cornerRadius(10)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.black.opacity(0.2), lineWidth: 1)
                    )
                    .background(Color.black.opacity(0.15).cornerRadius(20))
            }
        }
        
    }
    
    // Variable for mirror effect overlay
    private var mirrorEffectOverlayWithBorder: some View {
        ZStack {
            Color.white.opacity(0.0)
                .frame(height: 76)
                .cornerRadius(10)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.black.opacity(0.2), lineWidth: 1)
                )
                .overlay(
                    VStack(spacing: 0) {
                        LinearGradient(gradient: Gradient(colors: [Color.white.opacity(0.6), Color.white.opacity(0.05)]),
                                       startPoint: .top, endPoint: .bottom)
                            .mask(Rectangle().cornerRadius(10))
                            .frame(height: 38)
                        LinearGradient(gradient: Gradient(colors: [Color.white.opacity(0.05), Color.white.opacity(0.6)]),
                                       startPoint: .top, endPoint: .bottom)
                            .mask(Rectangle().cornerRadius(10))
                            .frame(height: 38)
                    }
                )
            Color.white.opacity(0.0)
                .frame(height: 72)
                .cornerRadius(10)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.black.opacity(0.6), lineWidth: 1)
                )
                .padding(.horizontal, 4)
            Color.white.opacity(0.0)
                .frame(height: 74)
                .cornerRadius(10)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.black.opacity(0.5), lineWidth: 1)
                )
                .padding(.horizontal, 3)
            Color.white.opacity(0.0)
                .frame(height: 76)
                .cornerRadius(10)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.black.opacity(0.4), lineWidth: 1)
                )
                .padding(.horizontal, 2)
            Color.white.opacity(0.0)
                .frame(height: 78)
                .cornerRadius(10)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.black.opacity(0.3), lineWidth: 1)
                )
                .padding(.horizontal, 1)
            Color.white.opacity(0.0)
                .frame(height: 80)
                .cornerRadius(10)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.black.opacity(0.2), lineWidth: 1)
                )

        }
    }
    
    // Variable for total earnings
    private var totalEarnings: some View {
        Text("Total earnings : \(viewModel.totalEarning)")
            .font(.largeTitle)
            .multilineTextAlignment(.center)
            .lineLimit(nil)
            .padding()
            .foregroundColor(Color(red: 1.0, green: 0.8, blue: 0.0))
            .background(Color.purple)
            .cornerRadius(10)
    }
    
    // Variable for buttons
    private var actionButtons: some View {
        HStack {
            Spacer()
            Button(action: viewModel.spinSlots) {
                Text("Spin")
                    .font(.title)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            Spacer()
            Button(action: viewModel.resetSlots) {
                Text("Reset")
                    .font(.title)
                    .padding()
                    .background(Color.red)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            Spacer()
        }
        .disabled(viewModel.isSpinning)
    }
    
    var body: some View {
        NavigationView{
            VStack(spacing: 0) {
                ZStack {
                    title
                    HStack {
                        darkModeEnableToggle
                        Spacer()
                        moreButton
                    }
                }
                Spacer()
                
                HStack(spacing: 0){
                    spinTapCount
                    Spacer()
                    animationRequired
                }
                .padding(.horizontal)
                
                Spacer()
                
                probabilityText
                Spacer()
                
                slotWheels
                    .overlay(mirrorEffectOverlayWithBorder)
                
                Spacer()
                //            if viewModel.showWinMessage {
                //                winMessage
                //                Spacer()
                //            }
                
                totalEarnings
                Spacer()
                
                actionButtons
                Spacer()
            }
        }
//        .padding()
        .alert(isPresented: $viewModel.showWinMessage) {
            Alert(title: Text(viewModel.wonAmount != 0 ? "Congratulations!" : "Uhhhh Ohhh!"),
                  message: Text(viewModel.wonAmount != 0 ? "You won \(viewModel.wonAmount) points!" : "Better Luck Next Time!"),
                  dismissButton: .default(Text(viewModel.wonAmount != 0 ? "OK" : "Try Again")){ // Add your action here
                viewModel.showWinMessage = false
                viewModel.wonAmount = 0
            }
            )
        }
        
    }
}

struct SlotMachineView_Previews: PreviewProvider {
    static var previews: some View {
        SlotMachineView()
    }
}
