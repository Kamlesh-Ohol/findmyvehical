import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
class AuthService {
   final FirebaseAuth _auth = FirebaseAuth.instance;
  // Future<UserCredential?> loginWithGoogle() async {
  //   try {
  //     final googleUser = await GoogleSignIn().signIn()
  //         );
  //     return cred.user;
  //   } on FirebaseAuthException catch (e) {
  //     print("Error during sign up: ${e.message}"); // Log the specific error
  //   } catch (e) {
  //     print("Something went wrong during sign up: $e");
  //   }
  //   return null;
  // }
  // Create a new user with email and password
  Future<User?> createUserWithEmailAndPassword(
      String email, String password) async {
    try {
      final UserCredential cred = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      return cred.user;
    } on FirebaseAuthException catch (e) {
      print("Error during sign up: ${e.message}"); // Log the specific error
    } catch (e) {
      print("Something went wrong during sign up: $e");
    }
    return null;
  }

  // Log in an existing user with email and password
  Future<User?> loginUserWithEmailAndPassword(
      String email, String password) async {
    try {
      final UserCredential cred = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      return cred.user;
    } on FirebaseAuthException catch (e) {
      print("Error during login: ${e.message}"); // Log the specific error
    } on FirebaseAuthException catch (e) {
      exceptionHandler(e.code);
    } catch (e) {
      print("Something went wrong during login: $e");
    }
    return null;
  }
  Future<void> ForgotPass(String email) async{
    try{
      await _auth.sendPasswordResetEmail(email: email);
    }catch(e){
      SnackBar(content: Text("Error Occoured"),);
    }
  }
  // Log out the current user
  Future<void> signOut() async {
    try {
      await _auth.signOut();
    } catch (e) {
      print("Something went wrong during sign out: $e");
    }
  }
}

exceptionHandler(String code) {
  switch (code) {
    case "invalid-credential":
      {
        print("your login credentials are invalid");
      }
    case "weak-password":
      {
        print("your password is weak");
      }
    case "email-already-in-use ":
      {
        print("email exists");
      }
    default:
      print("Something went wrong");
  }
}
