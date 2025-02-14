//
//  KnowYourDeveloperView.swift
//  A777SlotMachine
//
//  Created by Anurag Chourasia on 14/02/25.
//

import SwiftUI

public struct KnowYourDeveloperView: View {
    @AppStorage("isGridView") private var isGridView = false
    @State private var isExpanded = false
    @State private var shortSummary = "Experienced iOS Developer with over 3 years of hands-on experience in designing and building high-quality, user-centric mobile applications."
    @State private var fullSummary = """
    Experienced iOS Developer with over 3 years of hands-on experience in designing and building high-quality, user-centric mobile applications. \n
    Proficient in Swift, Objective-C, and SwiftUI, with a proven track record of delivering robust solutions that enhance user experience and drive business results. \n
    Skilled in team collaboration, code optimization, and bug fixing, consistently ensuring project delivery within tight deadlines. \n
    Passionate about staying updated with the latest industry trends and technologies to continually push the boundaries of mobile app development.
    """
    @State private var showAlert = false
    
    @Environment(\.presentationMode) var presentationMode
    
    // Title for the Know Your Developer View
    private var title: some View {
        Text("Know your developer")
            .font(.system(size: 26, weight: .bold, design: .default))
            .frame(maxWidth: .infinity)
            .foregroundStyle(Color("TextColor"))
            .padding(10)
    }
    
    // Backward button view
    private var backwardButton: some View {
        Button(action: {
            presentationMode.wrappedValue.dismiss()
        }){
            Image(systemName: "arrow.backward.circle")
                .resizable()
                .frame(width: 30, height: 30)
                .padding(10)
                .foregroundStyle(Color.primary)
        }
    }
    
    // Toggle style button view (list or grid)
    private var toggleStyleButton: some View {
        HStack {
            Spacer()
            Button(action: {
                withAnimation {
                    isGridView.toggle()
                }
            }) {
                Image(systemName: isGridView ? "list.bullet" : "square.grid.2x2")
                    .resizable()
                    .frame(width: 25, height: 25)
                    .foregroundStyle(Color("TextColor"))
            }
            .padding(10)
        }
    }
    
    // Line separator view
    private var lineSeparator: some View {
        Rectangle()
            .frame(height: 1)
            .foregroundColor(.gray)
    }
    
    // Enum for different logo types
    enum LogoType: String {
        case github = "Github"
        case linkedin = "Linkedin"
        case email = "Gmail"
        case skype = "Skype"
        case CV = "CV"
    }
    
    // Function to create a logo view based on the logo type
    private func logo(for type: LogoType) -> some View {
        Image(type.rawValue)
            .resizable()
            .frame(width: 40, height: 40)
            .padding(10)
            .background(Color.white.cornerRadius(10))
        
    }
    
    // Developer logo view
    private var devlogo: some View {
        Image("Anurag")
            .resizable()
            .frame(width: 100, height: 100)
            .cornerRadius(50)
            .padding(10)
            .overlay(Circle().stroke(Color("TextColor"), lineWidth: 2))
    }
    
    // Developer Description view
    private var devDescriptionView: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Anurag Chourasia")
                .font(.system(size: 20, weight: .bold, design: .monospaced))
                .foregroundStyle(Color("TextColor"))
            
            Text("iOS Engineer")
                .font(.system(size: 16, weight: .regular, design: .monospaced))
                .foregroundStyle(Color("TextColor"))
            
        }
        .frame(maxWidth: .infinity)
        .padding(10)
    }
    
    // Developer Summary View
    private var devSummaryView: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(fullSummary)
                .font(.system(size: 16, weight: .regular, design: .default))
                .lineLimit(isExpanded ? nil : 4)
                .frame(maxWidth: .infinity, alignment: .leading)
                .foregroundStyle(Color("TextColor"))
            Button(action: {
                withAnimation {
                    isExpanded.toggle()
                }
            }) {
                Text(isExpanded ? "Hide" : "Read More")
                    .font(.system(size: 16, weight: .bold, design: .default))
            }
        }
        .padding()
    }
    
    
    // Developer Section view
    private var devSectionView: some View {
        VStack(spacing: 0) {
            HStack(spacing: 0) {
                devlogo
                devDescriptionView
            }
            .padding(.vertical, 10)
            .padding(.horizontal, 10)
            //            devSummaryView
            TypingEffectView(text: $fullSummary)
        }
    }
    
    // Array of links with their corresponding logo types and URLs
    private var links: [(LogoType, String, URL)] {
        return [
            (.github, "GitHub", URL(string: "https://github.com/Anurag-Chourasia")!),
            (.linkedin, "LinkedIn", URL(string: "https://www.linkedin.com/in/anurag-chourasia-b66710178/")!),
            (.email, "Email", URL(string: "mailto:anuragchourasiaios@gmail.com")!),
            (.skype, "Skype", URL(string: "https://join.skype.com/invite/u4yGmOtKPfr6")!),
            (.CV, "CV (Google Drive)", URL(string: "https://drive.google.com/file/d/1nVmdpQ4bwfX83Wf92OVg9rvN6H3kUkvP/view")!)
        ]
    }
    
    // Developer Description view
    private var socialMediaSectionView: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Let's Connect")
                .font(.system(size: 20, weight: .bold, design: .monospaced))
                .frame(maxWidth: .infinity)
                .foregroundStyle(Color("TextColor"))
        }
        
        .padding(10)
    }
    
    // Profile logo and links view
    private var profileLogoAndLinks: some View {
        
        VStack(alignment: .leading, spacing: 0) {
            socialMediaSectionView
            if isGridView {
                let columns = [
                    GridItem(.flexible()),
                    GridItem(.flexible())
                ]
                LazyVGrid(columns: columns) {
                    ForEach(links, id: \.1) { link in
                        VStack(spacing: 0) {
                            Button(action: {
                                openURL(link.2)
                            }) {
                                VStack(spacing: 0) {
                                    Rectangle()
                                        .fill(Color.clear)
                                        .overlay(
                                            VStack {
                                                logo(for: link.0)
                                                Text(link.1.replacingFirstSpaceWithNewline() ?? "")
                                                    .multilineTextAlignment(.center)
                                            }
                                        )
                                }
                                .frame(width: 150, height: 150)
                                .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color("TextColor"), lineWidth: 1))
                                
                                
                            }
                            .padding(.vertical,20)
                        }
                        .aspectRatio(1, contentMode: .fit)
                    }
                }
            } else {
                LazyVGrid(columns: [GridItem()],spacing: 0) {
                    ForEach(links, id: \.1) { link in
                        Button(action: {
                            openURL(link.2)
                        }) {
                            HStack(spacing: 20) {
                                logo(for: link.0)
                                Text(link.1)
                                Spacer()
                            }
                            .padding(.leading, 30)
                            .padding()
                        }
                        .background(Rectangle().stroke(Color("TextColor"), lineWidth: 1))
                    }
                }
                .padding(.top,20)
            }
        }
        
    }
    
    public var body: some View {
        mainView
    }

    private var mainView: some View {
        NavigationView {
            VStack {
                ZStack(alignment: .leading) {
                    title
                    backwardButton
                    toggleStyleButton
                }
                lineSeparator
                ScrollView {
                    VStack {
                        devSectionView
                        lineSeparator
                        profileLogoAndLinks
                        Spacer()
                    }
                }
            }
            .alert(isPresented: $showAlert) {
                Alert(title: Text("Error"), message: Text("You don't have any app to open this link."), dismissButton: .default(Text("OK")))
            }
        }
        .navigationBarHidden(true)
    }
    
    private func openURL(_ url: URL) {
        if UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        } else {
            showAlert = true
        }
    }
    
}

struct KnowYourDeveloperView_Previews: PreviewProvider {
    static var previews: some View {
        KnowYourDeveloperView()
    }
}
