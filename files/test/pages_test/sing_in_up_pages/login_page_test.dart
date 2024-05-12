import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
import 'package:macquarie_application/constants/login_textfield.dart';
import 'package:macquarie_application/pages/sign_in_up_pages/login_page.dart';
import 'package:provider/provider.dart';

void main() {
  group('LoginPage Tests', () {
    // Mock Firebase Auth
    final mockFirebaseAuth = MockFirebaseAuth();

    Widget createWidgetUnderTest() {
      return MaterialApp(
        home: Provider<FirebaseAuth>(
          create: (_) => mockFirebaseAuth,
          child: LoginPage(
            onTap: () {},
          ),
        ),
      );
    }

    testWidgets('Renders email and password text fields and login button',
        (WidgetTester tester) async {
      await tester.pumpWidget(createWidgetUnderTest());

      expect(
          find.byType(TextField),
          findsNWidgets(
              2)); 
      expect(find.text('Sign In'),
          findsOneWidget); // Check for a button with the text 'Login'
    });

    testWidgets('Allows user to enter email and password',
        (WidgetTester tester) async {
      await tester.pumpWidget(createWidgetUnderTest());

      // Simulate user typing into the text fields
      await tester.enterText(
          find.byType(MyTextField).at(0), 'test@example.com');
      await tester.enterText(find.byType(MyTextField).at(1), 'password123');

      // Assert that the text fields contain the entered text
      expect(find.text('test@example.com'), findsOneWidget);
      expect(find.text('password123'), findsOneWidget);
    });

  });
}
