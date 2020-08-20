import 'package:flutter/material.dart';
import 'package:wasteagram/bloc/auth_bloc.dart';
import 'package:wasteagram/bloc/wasteagram_state.dart';
import 'package:wasteagram/widgets/authentication/login_button_standalone.dart';

class Authenticate extends StatefulWidget {
  final Widget child;

  Authenticate({@required this.child});

  void setChild() {}

  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  AuthBloc _authBloc;

  void didChangeDependencies() {
    super.didChangeDependencies();
    _authBloc = WasteagramStateContainer.of(context).blocProvider.authBloc;
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: _authBloc.user,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text('Error occurred with firebase auth');
          }
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
            // case ConnectionState.none:
            // // return Text('loading');
            // case ConnectionState.done:
            case ConnectionState.active:
              if (snapshot.data == null) {
                return LoginButtonStandalone();
              }
              return widget.child;
            default:
              return Text('default');
          }
        });
  }
}
