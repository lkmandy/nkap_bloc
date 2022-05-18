import 'package:integration_test/integration_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:nkap/main.dart';
import 'package:flutter/material.dart';

Future<void> addDelay(int ms) async {
  await Future<void>.delayed(Duration(milliseconds: ms));
}

Future<void> logout(WidgetTester tester) async {

  await addDelay(8000);
  await tester.tap(find.byKey(const ValueKey('LogoutKey'),
  ));

  await addDelay(8000);
  tester.printToConsole('Login screen opens');
  await tester.pumpAndSettle();
}

void main(){

  final binding = IntegrationTestWidgetsFlutterBinding.ensureInitialized()
  as IntegrationTestWidgetsFlutterBinding;

  if (binding is LiveTestWidgetsFlutterBinding) {
    binding.framePolicy = LiveTestWidgetsFlutterBindingFramePolicy.fullyLive;
  }

  group('end-to-end test', () {
    //TODO: add random email var here
    final timeBasedEmail = DateTime.now().microsecondsSinceEpoch.toString() + '@test.com';


    //TODO: add test 1 here
    testWidgets('Authentication Testing', (WidgetTester tester) async {
      //TODO: add Firebase Initialization Here
      await Firebase.initializeApp();
      await tester.pumpWidget(Nkap());
      await tester.pumpAndSettle();

      await tester.tap(find.byType(ElevatedButton));

      tester.printToConsole('SignUp screen opens');
      await tester.pumpAndSettle();
      await tester.enterText(find.byKey(const ValueKey('emailSignUpField')), timeBasedEmail);

      await tester.enterText(find.byKey(const ValueKey('passwordSignUpField')), 'test12uti3');
      //await tester.enterText(find.byKey(const ValueKey('confirmPasswordSignUpField')), 'test123');

      await tester.tap(find.byType(ElevatedButton));
      await addDelay(24000);
      await tester.pumpAndSettle();

      expect(find.text('Coins'), findsOneWidget);
      await logout(tester);
    });

    //TODO: add test 2 here

  });
}