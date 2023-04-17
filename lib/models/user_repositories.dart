import 'dart:async';

import 'package:api/models/results.dart';
import 'package:api/models/user.dart';
import 'package:api/services/auth_services.dart';
import 'package:api/utils/common.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:either_dart/either.dart';
import 'package:flutter/cupertino.dart';

class UserRepositories {
  final _authSevice = AuthService.instance;
  final userCollection = FirebaseFirestore.instance.collection("users");

  ValueNotifier<User?> currentUserNotifier = ValueNotifier<User?>(null);

  StreamSubscription<DocumentSnapshot<Map<String, dynamic>>>?
      _userStreamsSubscription;

  StreamSubscription? _authStreamsSubscription;
  set setCurrentUser(User? user) {
    currentUserNotifier.value = user;
    currentUserNotifier.notifyListeners();
  }

  UserRepositories() {
    _listenCurrentChanges();
  }

  void _listenCurrentChanges() {
    _authStreamsSubscription!.cancel();
    _authStreamsSubscription = null;
    _authStreamsSubscription = _authSevice.authState().listen(
      (firebaseUser) {
        if (firebaseUser != null) {
          final String uid = firebaseUser.uid;
          getCurrentUser(uid);
          authPrint("CURRENT USER -> $uid");
        } else {
          authPrint("NO CURRENT USER");
        }
      },
    );
  }

  Future<Either<Errorhandler, User>> registerUser(
      User user, String password) async {
    try {
      final firebaseUser = await _authSevice.signUp(user.email, password);
      if (firebaseUser != null) {
        final newUser = user.copyWith(uid: firebaseUser.uid);
        await userCollection.doc(firebaseUser.uid).set(newUser.toMap());
        await getCurrentUser(firebaseUser.uid);

        return Right(user);
      }
      return const Left(Errorhandler(message: "Couldn't register user"));
    } catch (e) {
      return Left(Errorhandler(message: e.toString()));
    }
  }

  Future<Either<Errorhandler, User>> getCurrentUser(String uid) async {
    try {
      final userSnapShot = await userCollection.doc(uid).get();
      if (userSnapShot.exists) {
        final data = userSnapShot.data() as Map<String, dynamic>;
        final User user = User.fromMap(data);
        listenCurrentUser(user.uid);
        setCurrentUser = user;
        return Right(user);
      }
      return const Left(Errorhandler(message: "User does not exist"));
    } catch (e) {
      print(e);
      return Left(Errorhandler(message: e.toString()));
    }
  }

  Future<Either<Errorhandler, User?>> login(
      String email, String password) async {
    try {
      final firebaseUser = await _authSevice.signIn(email, password);
      if (firebaseUser != null) {
        final getCurrentUserData = await getCurrentUser(firebaseUser.uid);
        if (getCurrentUserData.isRight) {
          return Right(getCurrentUserData.right);
        } else {
          return Left(getCurrentUserData.left);
        }
      }
      return const Left(Errorhandler(message: "Couldn't register user"));
    } catch (e) {
      print(e);
      return Left(Errorhandler(message: e.toString()));
    }
  }

  Stream<User?> listenCurrentUser(String uid) async* {
    try {
      final snapShot = userCollection.doc(uid).snapshots();
      _userStreamsSubscription?.cancel();
      _userStreamsSubscription = null;
      _userStreamsSubscription = snapShot.listen((document) {
        if (document.exists) {
          final data = document.data() as Map<String, dynamic>;
          final User user = User.fromMap(data);
          setCurrentUser = user;
        }
      });
    } catch (e) {
      authPrint(e);
    }
    yield currentUserNotifier.value;
  }
}
