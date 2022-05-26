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
    @State private var isAnimating: Bool = false
    
    private var circleButtonWidth: CGFloat = 80
    
    var body: some View {
        ZStack {
            // fullscreen bg
            Color("ColorBlue")
                .ignoresSafeArea(.all, edges: .all)
            
            VStack {
                // MARK: - header
                Spacer()
                
                VStack(spacing: 0) {
                    Text("WHAT'S THIS?")
                        .font(.system(size: 44))
                        .fontWeight(.heavy)
                        .foregroundColor(.black)
                    
                    // for long text, wrap with 3 """
                    Text("""
                    Try Object Recognition by MobileNetV2 (coreML model)
                    """)
                    .font(.title3)
                    .fontWeight(.light)
                    .foregroundColor(.black)
                    .multilineTextAlignment(.center)
                    .padding(10)
                } //: header
                .opacity(isAnimating ? 1 : 0)
                .offset(y: isAnimating ? 0 : -40)
                .animation(.easeOut(duration: 1), value: isAnimating)
                
                
                // MARK: - center
                
                ZStack{
                    Image("OnboardingHero")
                        .resizable()
                        .scaledToFit()
                    
                    //CircleGroupView(ShapeColor: .white, ShapeOpacity: 0.2)
                    
                } //: center
                
                Spacer()
                
                // MARK: - footer
                
                ZStack {
                    // 1. bg static
                    Capsule()
                        .fill(Color.white.opacity(0.2))
                    
                    Capsule()
                        .fill(Color.white.opacity(0.2))
                        .padding(8)
                    
                    // 2. call to action static
                    
                    Text("Get started")
                        .font(.system(.title3, design: .rounded))
                        .fontWeight(.bold)
                        .foregroundColor(.black)
                        .offset(x: 20)
                    
                    // 3. capsule (dynamic width)
                    HStack{
                        Capsule()
                            .fill(Color("ColorPink"))
                            // buttonOffset will start from 0, so add 80
                            .frame(width: slideButtonOffset + circleButtonWidth)
                        
                        // To push the red circle to the left
                        Spacer()
                    }
                    // 4. circle (draggable)
                    
                    HStack {
                        ZStack{
                            Circle()
                                .fill(Color("ColorPink"))
                            
                            Circle()
                                .fill(.black.opacity(0.15))
                                .padding(8)
                            
                            Image(systemName: "chevron.right.2")
                                .font(.system(size: 24, weight: .bold))
                        }
                        .foregroundColor(.white)
                        .frame(width: circleButtonWidth, height: circleButtonWidth, alignment: .center)
                        .offset(x: slideButtonOffset)
                        .gesture(
                            DragGesture()
                                .onChanged{ gesture in
                                    // This is triggered each time the drag gesture happened.
                                    
                                    // dragging direction left to right
                                    // gesture.translation is equivalent to location.{x,y} - startLocation.{x,y}. = amount of dragging
                                    if gesture.translation.width > 0 && slideButtonOffset <= slideButtonWidth - circleButtonWidth {
                                        slideButtonOffset = gesture.translation.width
                                    }
                                }
                                .onEnded { _ in
                                    if slideButtonOffset > slideButtonWidth / 2 {
                                        // when the button is in the right than half, move to the home screen
                                        slideButtonOffset = slideButtonWidth - circleButtonWidth
                                        isOnboardingViewActive = false
                                    } else {
                                        // the button is in the left than the half, back to the default position
                                        slideButtonOffset = 0
                                    }
                                    
                                }
                        ) //: Gesture
                        
                        // To push the button to the left edge
                        Spacer()
                    } //: ZStack
                    
                    
                } //: footer
                .frame(width: slideButtonWidth, height: 80, alignment: .center)
                .padding()
            } //: VSTACK
        } //: ZSTACK
        .onAppear(perform: {
            isAnimating = true
        })
    }
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView()
    }
}
