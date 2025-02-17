//
//  SplashView.swift
//  POIApp
//
//  Created by Samson Oluwapelumi on 16/02/2025.
//

import SwiftUI


struct SplashView: View {
    @State private var isActive: Bool = false
    @State private var size = 0.8
    @State private var opacity = 0.5

    var body: some View {
        NavigationStack {
            ZStack {
                Color.white
                    .edgesIgnoringSafeArea(.all)
                VStack {
                    Image("poiLogo")
                        .resizable()
                        .frame(width: 300, height: 300)
                        .scaleEffect(size)
                        .opacity(opacity)
                        .onAppear {
                            withAnimation(.easeIn(duration: 1.2)) {
                                self.size = 0.9
                                self.opacity = 1.0
                            }
                        }
                }
            }
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                    withAnimation {
                        self.isActive = true
                    }
                }
            }
            .navigationDestination(isPresented: $isActive) {
                LottieViewScreen().navigationBarBackButtonHidden(true)
            }
        }
    }
}
