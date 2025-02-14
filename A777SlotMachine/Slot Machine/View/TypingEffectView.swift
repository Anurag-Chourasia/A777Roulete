//
//  TypingEffectView.swift
//  A777SlotMachine
//
//  Created by Anurag Chourasia on 14/02/25.
//

import SwiftUI

struct TypingEffectView: View {
    @State private var currentWordIndex = 0
    @State private var isExpanded = false // State variable for the "Read More" button
    @State private var timer: Timer? // Timer variable
    
    @Binding var text: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            VStack(alignment: .leading, spacing: 10) {
                Text(buildTextUpToCurrentWord())
                    .font(.system(size: 16, weight: .regular, design: .default))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .onAppear {
                        currentWordIndex = calculateWordsInFirstLine()
                    }
                
                Button(action: {
                    withAnimation {
                        isExpanded.toggle()
                        if isExpanded {
                            startTypingEffect()
                        } else {
                            resetTypingEffect()
                        }
                    }
                }) {
                    Text(isExpanded ? "Hide" : "Read More")
                        .font(.system(size: 16, weight: .bold, design: .default))
                }
            }
            .padding()
            .onChange(of: isExpanded) {
                if isExpanded {
                    startTypingEffect()
                } else {
                    resetTypingEffect()
                }
            }
        }
    }
    
    private func startTypingEffect() {
        timer?.invalidate()
        currentWordIndex = calculateWordsInFirstLine()
        timer = Timer.scheduledTimer(withTimeInterval: 0.05, repeats: true) { timer in
            if currentWordIndex < text.split(separator: " ").count {
                withAnimation {
                    currentWordIndex += 1
                }
            } else {
                timer.invalidate()
            }
        }
    }
    
    private func resetTypingEffect() {
        timer?.invalidate()
        withAnimation {
            currentWordIndex = calculateWordsInFirstLine()
        }
    }
    
    private func buildTextUpToCurrentWord() -> String {
        let words = text.split(separator: " ").map { String($0) }
        let newString = words.prefix(currentWordIndex).joined(separator: " ")
        return newString
    }

    private func calculateWordsInFirstLine() -> Int {
        let textLineArray = text.split(separator: "\n")
        if let fistline = textLineArray.first {
            print("First line: \(fistline)")
            print("First line split: \(fistline.split(separator: " ").count)")
            return fistline.split(separator: " ").count
        } else {
            print("text split count: \(text.split(separator: " ").count)")
            return text.split(separator: " ").count
        }
    }
}

struct TypingEffectView_Previews: PreviewProvider {
    static var previews: some View {
        TypingEffectView(text: .constant("""
    Experienced iOS Developer with over 3 years of hands-on experience in designing and building high-quality, user-centric mobile applications. \n
    Proficient in Swift, Objective-C, and SwiftUI, with a proven track record of delivering robust solutions that enhance user experience and drive business results. \n
    Skilled in team collaboration, code optimization, and bug fixing, consistently ensuring project delivery within tight deadlines. \n
    Passionate about staying updated with the latest industry trends and technologies to continually push the boundaries of mobile app development.
    """))
    }
}
