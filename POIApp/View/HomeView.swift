//
//  HomeView.swift
//  POIApp
//
//  Created by Samson Oluwapelumi on 17/02/2025.
//

import SwiftUI
import MapKit


struct HomeView: View {
    
    @StateObject private var locationViewModel = LocationViewModel()
    @StateObject private var searchViewModel = SearchViewModel(region: MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 37.7749, longitude: -122.4194),
        span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)))

    @State private var isFirstLocationUpdate = true
    @State private var searchText = ""
    @State private var selectedPlace: MKMapItem?
    @State private var showPlaceDetail = false
    

    var body: some View {
        NavigationStack {
            ZStack {
                Color.black
                    .edgesIgnoringSafeArea(.all)

                VStack {
                    HStack {
                        Image("poiLogo")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 50, height: 50)
                            .clipShape(Circle())
                            .overlay(
                                Circle().stroke(Color.gray, lineWidth: 2)
                            )
                            .shadow(radius: 5)

                        Spacer()
                        NavigationLink(destination: FavoritesView().navigationBarBackButtonHidden(true)) {
                            Image("favoraite")
                                .resizable()
                                .frame(width: 40, height: 40)
                        }
                    }
                    .padding()

                    ZStack(alignment: .top) {
                        MapView(region: $searchViewModel.region,
                                annotations: $searchViewModel.annotations,
                                selectedPlace: $selectedPlace,
                                showPlaceDetail: $showPlaceDetail)
                        .edgesIgnoringSafeArea(.all)

                        SearchBar(text: $searchText,
                                  onCommit: { searchViewModel.searchForPlaces(searchText: searchText) },
                                  onCancel: { resetToUserLocation() })
                        .padding()
                        .background(Color.white.opacity(0.9))
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .shadow(radius: 3)
                        .padding(.horizontal)
                        .padding(.top, 20)
                    }
                    
                    
                }
                .sheet(isPresented: $showPlaceDetail) {
                    if let selectedPlace = selectedPlace {
                        PlaceDetailView(place: selectedPlace, dismissAction: { showPlaceDetail = false })
                            .presentationDetents([.medium, .large])
                    }
                }
                .onReceive(locationViewModel.$location) { location in
                    if let location = location, isFirstLocationUpdate {
                        let userRegion = MKCoordinateRegion(
                            center: location.coordinate,
                            span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
                        )
                        
                        locationViewModel.region = userRegion
                        searchViewModel.region = userRegion
                        isFirstLocationUpdate = false
                    }
                }
                .onAppear {
                    locationViewModel.requestLocation()
                }
            }
        }
    }

    private func resetToUserLocation() {
        if let userLocation = locationViewModel.location {
            let userRegion = MKCoordinateRegion(
                center: userLocation.coordinate,
                span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
            )

            searchViewModel.region = userRegion
            searchViewModel.annotations = []
        }
    }
}
