import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:rxdart/rxdart.dart';
import 'package:wasteagram/services/network/auth_service.dart';

enum LoginType { Gmail, Github, Facebook }

class AuthBloc {
  final AuthService _authService;

  static LoginType getLoginType(String str) {
    switch (str) {
      case 'facebook':
        return LoginType.Facebook;
      case 'github':
        return LoginType.Github;
      case 'gmail':
      default:
        return LoginType.Gmail;
    }
  }

  //Inputs - coming from app.

  //Outputs - either going to wasteagram or uses services to Firebase.
  Stream<User> get user => _authStatusController.stream;

  StreamController<User> _authStatusController =
      BehaviorSubject<User>(seedValue: null);

  AuthBloc(this._authService) {
    _authService.authStatus.listen((user) => _authStatusController.add(user));
  }

  Future<UserCredential> signIn(LoginType loginType, {BuildContext context}) {
    switch (loginType) {
      case LoginType.Github:
        return _authService.signInWithGitHub(context);
      case LoginType.Facebook:
      case LoginType.Gmail:
      default:
        return _authService.signInWithGoogle();
    }
  }

  Future logout() => _authService.logout();

  close() {
    _authStatusController.close();
  }
}

class LoginCredentials {
  String email;
  String password;
}
