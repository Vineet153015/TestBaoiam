import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class FirebaseAuthServices {
  FirebaseAuth _auth = FirebaseAuth.instance;

  // Method to display error messages
  void showError(String errorMessage) {
    // Print the error to the terminal
    print('Error: $errorMessage');

    // Show the error as a toast
    Fluttertoast.showToast(
      msg: errorMessage,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.grey,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }

  Future<User?> createWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential credential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return credential.user;
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'email-already-in-use':
          showError("The email address is already in use.");
          break;
        case 'invalid-email':
          showError("The email address is not valid.");
          break;
        case 'weak-password':
          showError("The password is too weak.");
          break;
        default:
          showError(e.message ?? "An unknown error occurred.");
      }
    } catch (e) {
      showError("An unexpected error occurred.");
    }
    return null;
  }

  Future<User?> signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential credential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return credential.user;
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'user-not-found':
          showError("No user found for that email.");
          break;
        case 'wrong-password':
          showError("Wrong password provided.");
          break;
        case 'invalid-email':
          showError("The email address is not valid.");
          break;
        default:
          showError(e.message ?? "An unknown error occurred.");
      }
    } catch (e) {
      showError("An unexpected error occurred.");
    }
    return null;
  }
}
