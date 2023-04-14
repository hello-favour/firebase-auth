import 'dart:async';

import 'package:api/home_page.dart';
import 'package:api/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class VerifiedEmail extends StatefulWidget {
  const VerifiedEmail({super.key});

  @override
  State<VerifiedEmail> createState() => _VerifiedEmailState();
}

class _VerifiedEmailState extends State<VerifiedEmail> {
  bool isVerifiedEmail = false;
  Timer? timer;
  // bool canResendEmail = false;

  @override
  void initState() {
    isVerifiedEmail = FirebaseAuth.instance.currentUser!.emailVerified;
    if (isVerifiedEmail) {
      sendVerificationEmail();
      timer = Timer.periodic(Duration(seconds: 3), (_) {
        CheckEmailVerified();
      });
    }
    super.initState();
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  Future sendVerificationEmail() async {
    try {
      final user = FirebaseAuth.instance.currentUser!;
      await user.sendEmailVerification();
      // setState(() => canResendEmail = false);
      // await Future.delayed(Duration(seconds: 2));
      // setState(() => canResendEmail = true);
    } catch (e) {
      Utils.showSnackBar(e.toString());
    }
  }

  Future CheckEmailVerified() async {
    await FirebaseAuth.instance.currentUser!.reload();
    setState(() {
      isVerifiedEmail = FirebaseAuth.instance.currentUser!.emailVerified;
    });

    if (isVerifiedEmail) {
      timer?.cancel();
    }
  }

  @override
  Widget build(BuildContext context) {
    return isVerifiedEmail
        ? const HomePage()
        : Scaffold(
            appBar: AppBar(
              title: const Text("Verified Email"),
            ),
            body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "A verification email has been sent to your email",
                    style: TextStyle(
                      fontSize: 20,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 24),
                  // ElevatedButton.icon(
                  //   onPressed: canResendEmail ? sendVerificationEmail : null,
                  //   icon: const Icon(
                  //     Icons.email,
                  //     size: 32,
                  //   ),
                  //   label: const Text(
                  //     "Resend email",
                  //     style: TextStyle(fontSize: 24),
                  //   ),
                  // ),
                  // const SizedBox(height: 8.0),
                  TextButton(
                    style: TextButton.styleFrom(
                      minimumSize: const Size.fromHeight(50),
                    ),
                    onPressed: () {
                      FirebaseAuth.instance.signOut();
                    },
                    child: const Text(
                      "Cancel",
                      style: TextStyle(fontSize: 24),
                    ),
                  ),
                ],
              ),
            ),
          );
  }
}
