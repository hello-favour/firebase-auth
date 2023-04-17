import 'dart:html';

import 'package:api/components/base_state.dart';
import 'package:api/models/user.dart';
import 'package:api/models/user_repositories.dart';
import 'package:api/services/get_it.dart';
import 'package:api/utils/common.dart';
import 'package:flutter/cupertino.dart';

class AuthenticationState extends BaseState {
  final userRepo = locate<UserRepositories>();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final formkey = GlobalKey<FormState>();
  void registerUser() async {
    final validate = formkey.currentState?.validate();
    if (validate != null && validate == true) {
      final user = User(
        uid: "",
        email: emailController.text,
        phone: "",
        profileImageUrl: "",
        createdAt: timeNow(),
        updatedAt: timeNow(),
        isActive: true,
        dob: 0,
      );
      final registerUser =
          await userRepo.registerUser(user, passwordController.text.trim());
      if (registerUser.isRight) {
        authPrint("Successfully register a user");
      } else {
        authPrint("${registerUser.isLeft} error");
      }
    }
  }

  void signInUser() async {
    final validate = formkey.currentState?.validate();
    if (validate != null && validate == true) {
      final registerUser = await userRepo.login(
          emailController.text.trim(), passwordController.text.trim());
      if (registerUser.isRight) {
        authPrint("Successfully register a user");
      } else {
        authPrint("${registerUser.isLeft} error");
      }
    }
  }
}
