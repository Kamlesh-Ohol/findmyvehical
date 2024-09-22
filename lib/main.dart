import 'package:findmyvehical/auth/firebase_options.dart';
import 'package:findmyvehical/auth/wrapper.dart';
import 'package:flutter/material.dart';
import 'login/signin.dart'; // Import your SignIn or SignUp page
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Firebase initialization with your platform-specific options
  await Firebase.initializeApp( name: 'find-my-ride-279d6',
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Wrapper(), // Use your actual initial page
    );
  }
}

class Mains extends StatelessWidget {
  const Mains({super.key});

  Future<void> fire() async {
    WidgetsFlutterBinding.ensureInitialized();
    try {
      if (kIsWeb) {
        await Firebase.initializeApp(
          options: DefaultFirebaseOptions.currentPlatform,
        );
      } else {
        // No need to pass the options again for mobile platforms, as it's already initialized
        await Firebase.initializeApp(
          options: DefaultFirebaseOptions.currentPlatform,
        );
      }
    } catch (e) {
      print("Error initializing Firebase: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(); // Replace with your actual widget tree
  }
}
