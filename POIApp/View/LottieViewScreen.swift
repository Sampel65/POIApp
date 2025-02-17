//
//  LottieViewScreen.swift
//  POIApp
//
//  Created by Samson Oluwapelumi on 17/02/2025.
//

import SwiftUI
import Lottie


struct LottieViewScreen: View {
    @State private var navigateToHome = false

    var body: some View {
        NavigationStack {
            ZStack {
                Color.white
                    .edgesIgnoringSafeArea(.all)

                LottieView(animationName: "welcome")
                    .frame(width: 350, height: 350)
            }
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 10.0) {
                    withAnimation {
                        self.navigateToHome = true
                    }
                }
            }
            .navigationDestination(isPresented: $navigateToHome) {
                HomeView().navigationBarBackButtonHidden(true)
            }
        }
    }
}
