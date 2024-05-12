import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:macquarie_application/pages/sign_in_up_pages/register_page.dart';

void main() {
  testWidgets('RegisterPage displays and toggles to login', (WidgetTester tester) async {
    // Create a dummy function to simulate page switch
    void mockToggle() {}

    await tester.pumpWidget(MaterialApp(home: RegisterPage(onTap: mockToggle)));

    // Verify that the email and password fields are present
    expect(find.byType(TextField), findsNWidgets(3)); 
    expect(find.text('Sign Up'), findsOneWidget);

    // Tap on the toggle button
    await tester.tap(find.text('Log In Now'));
    await tester.pumpAndSettle();

  });
}
