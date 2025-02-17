//
//  FavoritesView.swift
//  POIApp
//
//  Created by Samson Oluwapelumi on 17/02/2025.
//


import SwiftUI
import MapKit
import CoreData


struct FavoritesView: View {
    
    @FetchRequest(entity: Place.entity(), sortDescriptors: []) var savedPlaces: FetchedResults<Place>
    @Environment(\.presentationMode) var presentationMode
    @StateObject var searchViewModel = SearchViewModel(region: MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 37.7749, longitude: -122.4194),
        span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)))

    @StateObject private var viewModel = FavoritesViewModel()

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Color.white
                    .edgesIgnoringSafeArea(.all)
                
                VStack {
                    ZStack {
                        Color.black
                            .edgesIgnoringSafeArea(.top)
                        
                        HStack {
                            Button(action: {
                                presentationMode.wrappedValue.dismiss()
                            }) {
                                HStack(spacing: 8) {
                                    Image(systemName: "chevron.left")
                                        .foregroundColor(.white)
                                        .font(.headline)
                                    Text("Favorite Places")
                                        .font(.custom("Poppins-Regular", size: geometry.size.width * 0.05))
                                        .foregroundColor(.white)
                                }
                            }
                            Spacer()
                        }
                        .padding()
                    }
                    .frame(height: 60)
                    
                    ScrollView {
                        VStack(spacing: 15) {
                            ForEach(savedPlaces) { place in
                                PlaceCard(place: place, onDelete: {
                                    if let index = savedPlaces.firstIndex(of: place) {
                                        viewModel.deletePlace(at: IndexSet(integer: index), savedPlaces: savedPlaces)
                                    }
                                })
                                .onTapGesture {
                                    navigateToMap(place: place)
                                }
                            }
                        }
                        .padding(.horizontal)
                    }
                    Spacer()
                }
                .alert(isPresented: $viewModel.showAlert) {
                    Alert(title: Text("Status"), message: Text(viewModel.alertMessage), dismissButton: .default(Text("OK")))
                }
            }
        }
    }
    
    private func navigateToMap(place: Place) {
        let annotation = MKPointAnnotation()
        annotation.coordinate = CLLocationCoordinate2D(latitude: place.latitude, longitude: place.longitude)
        annotation.title = place.name

        DispatchQueue.main.async {
            searchViewModel.annotations = [annotation]
            searchViewModel.region = MKCoordinateRegion(
                center: annotation.coordinate,
                span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
            )
            presentationMode.wrappedValue.dismiss()
        }
    }
}






