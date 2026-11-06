import 'dart:developer' as developer;
import 'package:firebase_core/firebase_core.dart';

import '../firebase_options.dart';

class FirebaseService {
  static bool isInitialized = false;

  static Future<void> initialize() async {
    if (isInitialized) {
      return;
    }

    try {
      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );
      isInitialized = true;
      developer.log('Firebase initialized successfully.');
    } on UnsupportedError catch (error) {
      developer.log('Firebase config is missing: $error');
      isInitialized = false;
    } catch (error) {
      developer.log('Firebase initialization failed: $error');
      isInitialized = false;
    }
  }
}
