import 'package:flutter/material.dart';

class ForgetPassword extends StatefulWidget {
  final VoidCallback? showSignUp;
  const ForgetPassword({
    super.key,
    this.showSignUp,
  });

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF353535),
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Center(
              child: FlutterLogo(size: 80),
            ),
            const SizedBox(height: 15),
            const Text(
              "Receive and email to reset your password",
              style: TextStyle(
                color: Colors.white,
                fontSize: 30,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 25),
            const TextField(
              cursorColor: Colors.white,
              textInputAction: TextInputAction.done,
              decoration: InputDecoration(
                labelText: "Email",
                labelStyle: TextStyle(color: Colors.white),
              ),
            ),
            const TextField(
              cursorColor: Colors.white,
              decoration: InputDecoration(
                labelText: "Password",
                labelStyle: TextStyle(
                  color: Color(0xFF469D92),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Container(
              height: 50,
              width: double.infinity,
              color: const Color(0xFF469D92),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(
                    Icons.email,
                    color: Colors.white,
                  ),
                  SizedBox(width: 5),
                  Text(
                    "Reset Password",
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
