// // Imports the Flutter Driver API.
// import 'dart:io';
// import 'package:flutter_test/flutter_test.dart';


// // to start testing.
// // To run the test, we use the terminal and execute the following command:
// // $ flutter drive --target='test_driver/app.dart'


// void main() {
//   group('Joud App, The first test...', () {
//     // First, define the Finders and use them to locate widgets from the
//     // test suite. Note: the Strings provided to the `byValueKey` method must
//     // be the same as the Strings we used for the Keys in step 1.
//     //final emailTextFinder = find.byValueKey('counter');
//    // final passwordtext = find.byValueKey('increment');

//     // FlutterDriver driver;

//     // // Connect to the Flutter driver before running any tests.
//     // setUpAll(() async {
//     //   driver = await FlutterDriver.connect();
//     // });

//     // // Close the connection to the driver after the tests have completed.
//     // tearDownAll(() async {
//     //   if (driver != null) {
//     //     driver.close();
//     //   }
//     });


// //3
// // ot);    test('take a screenshot', () async {
// //   final header = find.text('Contacts');
// //   await driver.waitFor(header);
  
// //   await Directory('screenshots').create();
// //   final screenshot = await driver.screenshot();
// //   final fileDescriptor = File('screenshots/contact_list.png');
// //   fileDescriptor.writeAsBytes(screensh
// //});
// //  });

// // group('Validator', () {
// //     final validator = Validator();

// //     test('Password Test', () {

// //       expect(validator.validatePassword(''), PasswordValidationResults.EMPTY_PASSWORD);
// //       expect(validator.validatePassword('passw'), PasswordValidationResults.TOO_SHORT);
// //       expect(validator.validatePassword('validPass'), PasswordValidationResults.VALID);
// //     });

// //     test('Email Test', () {
// //       expect(validator.validateEmail(''), EmailValidationResults.EMPTY_EMAIL);
// //       expect(validator.validateEmail('email.com'), EmailValidationResults.NON_VALID);
// //       expect(validator.validateEmail('email@hmail.1'), EmailValidationResults.NON_VALID);
// //       expect(validator.validateEmail('email@hmail.com'), EmailValidationResults.VALID);
// //     });
//   //});

// }

