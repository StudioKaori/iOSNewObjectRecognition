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
    // this value will be constantly changed while the button is dragged.
    @State private var slideButtonOffset: CGFloat = 0
    
    private var circleButtonWidth: CGFloat = 80
    
    var body: some View {
        ZStack {
            // fullscreen bg
            Color("ColorBlue")
                .ignoresSafeArea(.all, edges: .all)
        }
    }
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView()
    }
}
