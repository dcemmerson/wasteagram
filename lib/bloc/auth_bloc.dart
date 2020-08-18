import 'dart:async';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';

import 'package:rxdart/rxdart.dart';
import 'package:wasteagram/services/network/auth_service.dart';

class AuthBloc {
  final AuthService _authService;

  //Inputs - coming from app.

  //Outputs - either going to wasteagram or uses services to Firebase.
  Stream<User> get authStatus => _authStatusController.stream;
  StreamController<User> _authStatusController =
      BehaviorSubject<User>(seedValue: null);

  AuthBloc(this._authService) {
    _authService.authStatus.listen((user) => _authStatusController.add(user));
  }

  Future<UserCredential> signInWithGoogle() => _authService.signInWithGoogle();

  close() {
    _authStatusController.close();
  }
}

class LoginCredentials {
  String email;
  String password;
}
