//import 'package:flutter_driver/driver_extension.dart';
import 'package:joud_app/main.dart' as app;

void main() {
  // This line enables the extension.
 // enableFlutterDriverExtension();

  // Call the `main()` function of the app, or call `runApp` with
  // any widget you are interested in testing.
  app.main();
}
// import 'package:flutter_test/flutter_test.dart';
// import 'validator.dart';

// void main() {
//   test('Validator Test', () {
//     final validator = Validator();

//     expect(validator.validatePassword(''), ValidResults.EMPTY_PASSWORD);
//     expect(validator.validatePassword('passw'), ValidResults.TOO_SHORT);
//     expect(validator.validatePassword('validPass'), ValidResults.VALID);
//   });
// }


//void main() => integrationDriver();
