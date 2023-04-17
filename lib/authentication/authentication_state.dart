import 'package:api/components/base_state.dart';
import 'package:api/models/user.dart';
import 'package:api/models/user_repositories.dart';
import 'package:api/services/get_it.dart';
import 'package:api/utils/common.dart';
import 'package:flutter/cupertino.dart';

enum ButtonState {
  loading,
  idle,
  disable;
}

class AuthenticationState extends BaseState {
  final userRepo = locate<UserRepositories>();

  User? currentUser;

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  AuthenticationState() {
    if (currentUser == null) {
      _userNotifier();
    }
    userRepo.currentUserNotifier.addListener(_userNotifier);
  }

  @override
  void dispose() {
    userRepo.currentUserNotifier.removeListener(_userNotifier);
    super.dispose();
  }

  final formkey = GlobalKey<FormState>();
  void registerUser() async {
    final validate = formkey.currentState?.validate();
    if (validate != null && validate == true && isLoading == false) {
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
      setLoading(true);
      final register =
          await userRepo.registerUser(user, passwordController.text.trim());
      setLoading(false);
      if (register.isRight) {
        authPrint("Successfully register a user");
      } else {
        authPrint("${register.isLeft} error");
      }
    }
  }

  void signInUser() async {
    final validate = formkey.currentState?.validate();
    if (validate != null && validate == true && isLoading == false) {
      setLoading(true);
      final register = await userRepo.login(
          emailController.text.trim(), passwordController.text.trim());
      setLoading(true);
      if (register.isRight) {
        authPrint("Successfully login a user");
      } else {
        authPrint("${register.isLeft} error");
      }
    }
  }

  void _userNotifier() {
    currentUser = userRepo.currentUserNotifier.value;
    notifyListeners();
  }
}
