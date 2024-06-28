import 'package:firebase_core/firebase_core.dart';
import 'package:recetas/firebase_options.dart';

class FirebaseServices {
  static Future<FirebaseServices> init() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    return FirebaseServices();
  }
}
