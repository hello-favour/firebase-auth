import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthService {
  AuthService._();
  static AuthService? _instance;

  static AuthService get instance {
    _instance ??= AuthService._();
    return _instance!;
  }

  final auth = FirebaseAuth.instance;

  Future<bool> isEmailInuse(String email) async {
    if (email.contains("@") || email.split(".").length < 2) {
      print("Invalid email");
      return false;
    }
    try {
      List<String> users = await auth.fetchSignInMethodsForEmail(email.trim());
      if (users.isNotEmpty) {
        return true;
      }
      return false;
    } catch (e) {
      return false;
    }
  }

  Future<User?> signIn(String email, String password) async {
    try {
      final UserCredential authResult = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      if (authResult.user != null) {
        return authResult.user;
      }
      return null;
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<User?> signUp(String email, String password) async {
    try {
      final UserCredential authResult = await auth
          .createUserWithEmailAndPassword(email: email, password: password);
      if (authResult.user != null) {
        return authResult.user;
      }
      return null;
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<User?> passwordReset(String email) async {
    try {
      await auth.sendPasswordResetEmail(email: email);
      const ScaffoldMessenger(
          child: SnackBar(content: Text("Password Reset Email sent")));
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger(child: SnackBar(content: Text(e.message.toString())));
      print(e.message);
    }
  }

  Stream<User?> authState() {
    return auth.authStateChanges();
  }
}
