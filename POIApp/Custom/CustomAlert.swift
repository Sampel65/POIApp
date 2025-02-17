//
//  CustomAlert.swift
//  DropInnovation
//
//  Created by Samson Oluwapelumi on 02/01/2025.
//


import SwiftUI


struct CustomAlert: View {
    var gifName: String
    var title: String
    var message: String
    var onDismiss: () -> Void

    var body: some View {
        VStack(spacing: 20) {

            LottieView(animationName: gifName)
                .frame(width: 200, height: 200)

            Text(title)
                .font(.headline)
                .foregroundColor(.black)

            Text(message)
                .font(.body)
                .multilineTextAlignment(.center)
                .foregroundColor(.gray)
                .padding(.horizontal)


            Button(action: onDismiss) {
                Text("OK")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.black)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .padding(.horizontal, 20)
        }
        .padding()
        .background(Color.white)
        .cornerRadius(15)
        .shadow(radius: 10)
        .frame(maxWidth: 300)
    }
}


