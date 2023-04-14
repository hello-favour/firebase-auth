import 'package:api/auth_page.dart';
import 'package:api/home_page.dart';
import 'package:api/verified_email.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return const Center(child: Text("Something went wrong"));
        } else if (snapshot.hasData) {
          return const VerifiedEmail();
        } else {
          return const AuthPage();
        }
      },
    );
  }
}
