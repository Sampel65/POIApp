//
//  PlaceDetailView.swift
//  POIApp
//
//  Created by Samson Oluwapelumi on 17/02/2025.
//
import SwiftUI
import MapKit


struct PlaceDetailView: View {
    var place: MKMapItem
    var dismissAction: () -> Void
    
    @State private var showAlert = false
    @State private var alertMessage = ""
    @State private var alertType: AlertType = .success

    enum AlertType {
        case success
        case failure
    }

    var body: some View {
        ZStack {
            VStack {
                VStack(spacing: 15) {
                    Text(place.name ?? "Unknown")
                        .font(.title)
                        .bold()
                    
                    // Full address from MKPlacemark components
                    let fullAddress = [
                        place.placemark.subThoroughfare,
                        place.placemark.thoroughfare,
                        place.placemark.locality,
                        place.placemark.administrativeArea,
                        place.placemark.postalCode,
                        place.placemark.country
                    ]
                    .compactMap { $0 }
                    .joined(separator: ", ")
                    
                    Text(fullAddress.isEmpty ? "No full address available" : fullAddress)
                        .font(.subheadline)
                        .foregroundColor(.gray)
                    
                    Button(action: {
                        PersistenceManager.shared.savePlace(
                            name: place.name ?? "Unknown",
                            address: fullAddress.isEmpty ? "No address" : fullAddress,
                            latitude: place.placemark.coordinate.latitude,
                            longitude: place.placemark.coordinate.longitude
                        ) { message in
                            DispatchQueue.main.async {
                                self.alertMessage = message
                                self.alertType = message.contains("success") ? .success : .failure
                                self.showAlert = true
                            }
                        }
                    }) {
                        Text("Save to Favorites")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.green.opacity(0.8))
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                }
                .padding()
                .background(Color.white)
                .cornerRadius(15)
                .shadow(radius: 10)
                .padding(.horizontal)
            }
            
            // Alert Overlay
            if showAlert {
                Color.black.opacity(0.3)
                    .edgesIgnoringSafeArea(.all)
                    .onTapGesture {
                        showAlert = false
                    }
                
                CustomAlert(
                    gifName: alertType == .success ? "success" : "error",
                    title: alertType == .success ? "Success" : "Failed",
                    message: alertMessage
                ) {
                    withAnimation {
                        showAlert = false
                    }
                }
                .transition(.scale)
                .zIndex(1) // Ensure the alert is on top of other views
            }
        }
    }
}

