# University Campus App

## Overview
This Flutter application is designed to enhance the campus experience for university students by providing critical information and interactive features. It includes user authentication, an interactive campus map, a news feed, and a coffee shop interface with a shopping cart and order history functionality.

## Main Functionality
- **User Authentication**: Supports email and Google sign-in for personalized user experience.
- **Interactive Campus Map**: Features detailed overlays with links to additional information about key locations on campus.
- **Theme Switching**: Real-time theme switching between light and dark modes to suit user preferences and enhance accessibility.
- **Coffee Shop Interface**: Allows users to order beverages, view order history, and manage a shopping cart.
- **News Feed**: Keeps students updated with the latest campus news, dynamically pulled from online sources.

## Target Audience
Our target audience includes students, staff, as well as visitors of a university. These users have diverse needs and preferences. Addressing those needs, our application offers a range of features such as ordering coffee from coffee shops around the university campus, finding parking at the university parking area, looking up the latest news, as well as exploring the campus by looking at the university's map and looking for more information by visiting the website of some locations around the campus. By catering to the needs of our diverse user base, we aim to create a more inclusive and user-friendly campus environment.

## Testing Devices
All my testing were done on Chrome, Android Emulator (Pixel 3, Pixel 8 Pro), and on my physical device (Pixel 7 Pro) by enabling Developers Options and USB debugging from the mobile's Setting, and using a UCB Type-C to connect my PC to my mobile phone.

## Bugs and Incompatibilities 
- I had a couple of problems when launching URLs on Android Emulator, however, they were launching perfectly on my physical mobile phone.
- Sometimes when using my physical phone, I try to log out, but the the screen freezes for some reason, even after heavy debugging and inserting texts inside methods, and monitoring the debug console, it seems like the problem was from the phone, not from the code, since I have never faced this error when running my code on Chrome.
- Google Sign-In is only functional on Mobile, not on Chrome.

## Installation
To set up the project locally, follow these steps:
```bash
git clone https://github.com/MajdIssa34/CampusMobileApp.git
cd campusmobileapp
flutter pub get
flutter run
```

## Usage
After installation, run the app to access various features:

- Log in using your credentials or through Google.
- Navigate using the bottom navigation bar to explore different features like the map, coffee shop, and news feed.
- Switch themes from the drawer menu for better visibility depending on lighting conditions.

## Architecture
The application utilizes the Provider package for state management, ensuring efficient and scalable management of app state across multiple widgets and screens.

## Dependencies
- 'firebase_auth': Manages user authentication.
- 'google_fonts': Enhances UI typography.
- provider': Manages state across the app.
- 'url_launcher': Opens web links within the app.

## Testing
The app includes comprehensive tests:

- Widget Tests: Ensures each screen renders correctly.
- Unit Tests: Validates business logic in the shopping cart and authentication processes.
Example:
```dart
void main() {
  testWidgets('Home screen renders correctly', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: HomePage()));
    expect(find.text('Latest News'), findsOneWidget);
  });
}
```

## Developers
Majd Issa - Initial work and main development
## Acknowledgments
- Flutter documentation and community for guidance.
- Firebase for authentication and database solutions.
- Google Fonts for typography enhancements.
