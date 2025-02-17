//
//  PlaceCard.swift
//  POIApp
//
//  Created by Samson Oluwapelumi on 17/02/2025.
//
import SwiftUI

struct PlaceCard: View {
    let place: Place
    var onDelete: () -> Void

    var body: some View {
        HStack(spacing: 15) {
            Image("location")
                .resizable()
                .frame(width: 40, height: 40)

            
            VStack(alignment: .leading, spacing: 5) {
                Text(place.name ?? "Unknown Place")
                    .font(.headline)
                    .foregroundColor(.primary)
                Text(place.address ?? "No address available")
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
            Spacer()

            Button(action: onDelete) {
                Image(systemName: "trash")
                    .foregroundColor(.red)
            }
        }
        .padding()
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .shadow(radius: 3)
    }
}
