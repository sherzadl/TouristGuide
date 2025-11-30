# Tourist Guide App (Uzbekistan)

A Flutter mobile application that helps tourists explore Uzbekistan by regions and categories, discover must-visit places, view locations on map, and save favorites for trip planning.

## Features

- **Explore by Regions**
  - Home page shows popular regions with cover images.
  - Tap a region to see all places inside.

- **Explore by Categories**
  - Categories page with animated GIF icons.
  - Shows all matching places across Uzbekistan.

- **Place Details**
  - Full information: description, rating, visiting hours, ticket info, tips.
  - **Open in Google Maps** for navigation.
  - Mock **user reviews** for each place.

- **Must-Visit Places**
  - Top recommended places in Uzbekistan displayed with ranking.

- **Favorites**
  - Save places you like to Favorites for easy access.

- **Nearby / Map**
  - Google Maps screen to view places and nearby locations.

- **Light / Dark Mode**
  - Global theme toggle for better user experience.

- **Search**
  - Search places by name or city using SearchDelegate.

## Course Topics Covered

This project demonstrates the following Flutter & Mobile Development topics:

- Dart Programming Fundamentals (models, lists, filtering, sorting)
- Flutter Widgets (custom UI, cards, grid/list layouts)
- State Management (Riverpod for favorites & theme)
- Navigation and Routing (go_router with nested routes)
- APIs and Networking (Google Maps API integration)
- Persisting Data (favorites architecture ready for local/cloud storage)
- Advanced UI Design (modern cards, gradients, animations, Hero-ready layouts)
- Firebase Authentication & Firestore (planned / teammate implementing)
- Testing & Debugging (project structured for unit & widget tests)
- App Deployment (APK build for Android)

## Project Structure
lib/
├─ app/ # router, tabs scaffold
├─ features/
│ ├─ places/ # places data + UI screens
│ ├─ regions/ # region list + regional places
│ └─ splash/ # splash screen
├─ shared/ # providers, theme, helpers
└─ main.dart # app entry
assets/
├─ places/ # place images
├─ regions/ # region covers
└─ gifs/ # animated category icons


## Getting Started

### Requirements
- Flutter SDK
- Android Studio / VS Code
- Android Emulator or physical device

## Demo

Main user flow:
1. Splash → Regions Dashboard  
2. Choose region → Places list  
3. Tap a place → Detail page + tips + reviews  
4. Open place in Maps  
5. Save favorites  
6. Explore via Categories / Must-Visit / Nearby tabs  

Credits / Sources

Place images and descriptions are used for educational purposes.
Google Maps API is used for mapping and navigation.
