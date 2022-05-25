//
//  ContentView.swift
//  NewObjectRecognition
//
//  Created by Kaori Persson on 2022-05-24.
//

import SwiftUI

struct ContentView: View {
    
    // AppStorage: Store the key in the app permanent storage
    @AppStorage("onboarding") var isOnboardingViewActive: Bool = true
    
    var body: some View {
        ZStack {
            if isOnboardingViewActive {
                OnboardingView()
            } else {
                HomeView()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
