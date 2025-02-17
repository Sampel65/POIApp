# POI Finder App

This is a simple iOS application that displays points of interest (POIs) around a user’s current location using Apple Maps and the MapKit framework. The app allows users to:

-View their current location on an Apple Map.

-Search for nearby places (e.g., restaurants, cafes, gas stations) using Apple’s MKLocalSearch API.

-Select a place to see more details (e.g., name, category, address).

-Save favorite locations for offline access using CoreData.

Features
1. UI & User Experience
Clean and responsive UI built with SwiftUI.

2. Apple Maps & Location Services
Fetches and displays the user’s current location using CoreLocation.

Handles location permissions (requesting, denying, or revoking access).

Fallback mechanism to a default location if location access is denied.

3. Search & Display Nearby Places
Uses MKLocalSearch to find nearby POIs based on user-defined categories.

Displays search results on the map with custom annotations.

Retry mechanism for failed searches due to network issues.

4. Data Persistence (Offline Feature)
Saves favorite places using CoreData for offline access.

Immediate updates to the FavoritesView when a place is saved or deleted.

5. Networking & API Handling
Robust error handling for MKLocalSearch and MKLocalSearchCompleter.

Retry mechanism for failed searches.

6. Code Quality & Best Practices
Follows MVVM architecture for clean separation of concerns.

Adheres to SOLID principles and best coding practices.


How to Run the App
Prerequisites
Xcode 14 or later.
iOS 16 or later.

A physical device or simulator with location services enabled.

Steps
-Clone the repository:

git clone https://github.com/sampel65/POIApp.git

-Open the project in Xcode:

cd POIApp
open POIApp.xcodeproj
Build and run the app on a simulator or a physical device.

Assumptions
The app assumes that the user has granted location permissions.

The app uses CoreData for local storage, so it requires iOS 13 or later.

Limitations
The app does not handle all edge cases for location services (e.g., if the user denies location access).

The app does not include extensive unit tests.

Areas for Improvement
Add more robust error handling for location services and network requests.

Implement a retry mechanism for failed searches.

Add more unit tests, especially for the PersistenceManager and SearchViewModel.

Approach
The app follows the MVVM architecture to separate concerns and improve maintainability.

The app uses Combine for reactive programming, especially for handling location updates.

CoreData is used for local storage, allowing users to save favorite places for offline access.

Trade-offs & Challenges
Due to time constraints, not all edge cases were handled (e.g., network failures, location access denied).

The app could benefit from more extensive unit testing, but this was not completed due to time limitations.




https://github.com/user-attachments/assets/16c59e3e-29c4-4527-9e82-c2ac5e304a8b



https://github.com/user-attachments/assets/4e6d4ac3-cce2-4e10-ba19-24cf8d275174
![IMG_5108](https://github.com/user-attachments/assets/a9415976-b30f-4c8a-8bad-f553afbcad46)
![IMG_5109](https://github.com/user-attachments/assets/147c761a-e368-4e82-aad2-4ed819b12708)
![IMG_5110](https://github.com/user-attachments/assets/79c5f42c-49fc-4f70-b326-1181aea508b0)
![IMG_5111](https://github.com/user-attachments/assets/371725eb-2c82-4c23-8c7e-33448b41bac9)
![IMG_5112](https://github.com/user-attachments/assets/b32eb1d6-37f7-4275-871b-4b9a14bb30f0)
![IMG_5113](https://github.com/user-attachments/assets/44f390c1-fba1-4461-a469-881621508b23)
![IMG_5114](https://github.com/user-attachments/assets/e2bb99bd-3d82-465b-af27-79ff1694555e)

