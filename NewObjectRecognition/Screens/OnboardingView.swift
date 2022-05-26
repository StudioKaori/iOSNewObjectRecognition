//
//  OnboardingView.swift
//  NewObjectRecognition
//
//  Created by Kaori Persson on 2022-05-25.
//

import SwiftUI

struct OnboardingView: View {
    
    // MARK: property
    // if the isOnboardingViewActive was found in app strage, this would be skipped.
    @AppStorage("onboarding") var isOnboardingViewActive: Bool = true
    
    // slide button width will be always the screen width - 80(40 padding for each)
    @State private var slideButtonWidth: Double = UIScreen.main.bounds.width - 80
    @State private var slideButtonOffset: CGFloat = 0
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView()
    }
}
