import 'package:api/services/auth_services.dart';
import 'package:flutter/material.dart';

class SignUp extends StatefulWidget {
  final VoidCallback? showLogin;
  const SignUp({
    super.key,
    this.showLogin,
  });

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
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
              "Hey There, \n Welcome Back",
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
            InkWell(
              onTap: () {
                AuthService.instance
                    .signUp("favor@gmail.com", "123123123")
                    .then((value) {
                  if (value != null) {
                    print("Signed Up User: !${value.email}");
                  }
                });
              },
              child: Container(
                height: 50,
                width: double.infinity,
                color: const Color(0xFF469D92),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(
                      Icons.arrow_forward,
                      color: Colors.white,
                    ),
                    SizedBox(width: 5),
                    Text(
                      "Sign Up",
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Already have an Account?",
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(width: 5),
                GestureDetector(
                  onTap: () {},
                  child: const Text(
                    "Log In?",
                    style: TextStyle(
                      fontSize: 20,
                      color: Color(0xFF469D92),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
