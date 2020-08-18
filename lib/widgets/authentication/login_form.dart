import 'package:flutter/material.dart';
import 'package:wasteagram/bloc/auth_bloc.dart';
import 'package:wasteagram/bloc/wasteagram_state.dart';

class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  Key _key = GlobalKey();
  AuthBloc _authBloc;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _authBloc = WasteagramStateContainer.of(context).blocProvider.authBloc;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(children: [
        Row(children: [
          RaisedButton(
            child: Icon(Icons.account_box),
            onPressed: _authBloc.signInWithGoogle,
          ),
        ]),
      ]),
    );
  }
}
