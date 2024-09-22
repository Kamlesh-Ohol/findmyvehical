import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart';

// class DefaultFirebaseOptions {
//   static FirebaseOptions get currentPlatform {
//     return const FirebaseOptions(
//         apiKey: "AIzaSyAL00RIRMtV5Yh_eZXmDud3TciA7RxcF6g",
//         authDomain: "find-my-ride-279d6.firebaseapp.com",
//         projectId: "find-my-ride-279d6",
//         storageBucket: "find-my-ride-279d6.appspot.com",
//         messagingSenderId: "449922112184",
//         appId: "1:449922112184:web:0992953cc5a039c7c7b24d",
//         measurementId: "G-WM7QTSGVMZ"
//     );
//   }
//
// }

// firebase_options.dart
// import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
// import 'package:flutter/foundation.dart' show kIsWeb;

/// Default Firebase configuration for your project.
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    } else if (defaultTargetPlatform == TargetPlatform.android) {
      return android;
    }
    throw UnsupportedError('Unsupported platform');
  }

  static const FirebaseOptions web = FirebaseOptions(
      apiKey: "AIzaSyAL00RIRMtV5Yh_eZXmDud3TciA7RxcF6g",
      authDomain: "find-my-ride-279d6.firebaseapp.com",
      projectId: "find-my-ride-279d6",
      storageBucket: "find-my-ride-279d6.appspot.com",
      messagingSenderId: "449922112184",
      appId: "1:449922112184:web:0992953cc5a039c7c7b24d",
      measurementId: "G-WM7QTSGVMZ"
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: "AIzaSyAL00RIRMtV5Yh_eZXmDud3TciA7RxcF6g",
    authDomain: "find-my-ride-279d6.firebaseapp.com",
    projectId: "find-my-ride-279d6",
    storageBucket: "find-my-ride-279d6.appspot.com",
    messagingSenderId: "449922112184",
    appId: "1:449922112184:web:0992953cc5a039c7c7b24d",
  );
}
