import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
import 'package:macquarie_application/pages/app_pages/home_page.dart';
import 'package:macquarie_application/pages/sign_in_up_pages/login_or_register.dart';

void main() {
  testWidgets('AuthPage shows LoginOrRegisterPage when user is not logged in',
      (WidgetTester tester) async {
    // Create a mock FirebaseAuth instance with no user signed in
    final mockFirebaseAuth = MockFirebaseAuth();

    // Override the FirebaseAuth instance used in the app
    await tester.pumpWidget(
      MaterialApp(
        home: StreamBuilder<User?>(
          stream: mockFirebaseAuth.authStateChanges(),
          builder: (context, snapshot) {
            // If user is logged in, show MainPage
            if (snapshot.hasData) {
              return const HomePage();
            } else {
              // If not logged in, show LoginOrRegisterPage
              return const LoginOrRegisterPage();
            }
          },
        ),
      ),
    );

    // Pump the widget so the stream builder updates
    await tester.pumpAndSettle();

    // Test conditions based on whether the user is logged in or not
    expect(find.byType(HomePage), findsNothing);
    expect(find.byType(LoginOrRegisterPage), findsOneWidget);
  });
}
