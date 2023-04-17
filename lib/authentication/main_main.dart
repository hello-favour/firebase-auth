import 'package:api/authentication/home.dart';
import 'package:api/authentication/sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MainMain extends StatefulWidget {
  const MainMain({super.key});

  @override
  State<MainMain> createState() => _MainMainState();
}

class _MainMainState extends State<MainMain> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return const Center(child: Text("Something went  wrong"));
        } else if (snapshot.hasData) {
          return const SignIn();
        } else {
          return const SignIn();
        }
      },
    );
  }
}
