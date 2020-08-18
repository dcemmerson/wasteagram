import 'package:flutter/material.dart';
import 'package:wasteagram/widgets/authentication/authentication.dart';

class AuthenticationPage extends StatefulWidget {
  static const route = '/';
  static const title = 'Login';

  @override
  _AuthenticationPageState createState() => _AuthenticationPageState();
}

class _AuthenticationPageState extends State<AuthenticationPage> {
  @override
  Widget build(BuildContext context) {
    return Authentication();
  }
}
