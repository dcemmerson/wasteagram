import 'package:flutter/material.dart';
import 'package:wasteagram/bloc/auth_bloc.dart';
import 'package:wasteagram/bloc/wasteagram_state.dart';
import 'package:wasteagram/widgets/authentication/login_button_standalone.dart';
import 'package:wasteagram/widgets/drawer/login_button.dart';
import 'package:wasteagram/widgets/waste_list_view/waste_items_list.dart';

class Authentication extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Authentication> {
  AuthBloc _authBloc;

  void didChangeDependencies() {
    super.didChangeDependencies();
    _authBloc = WasteagramStateContainer.of(context).blocProvider.authBloc;
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: _authBloc.authStatus,
        builder: (context, snapshot) {
          print('build authentication');
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
              return WasteItems();
            default:
              return Text('default');
          }
        });
  }
}
