import 'package:flutter/material.dart';
import 'package:wasteagram/bloc/auth_bloc.dart';
import 'package:wasteagram/bloc/wasteagram_state.dart';
import 'package:wasteagram/styles/styles.dart';

class LoginButton extends StatefulWidget {
  final loginAnimationDuration = const Duration(milliseconds: 250);

  @override
  _LoginButtonState createState() => _LoginButtonState();
}

class _LoginButtonState extends State<LoginButton>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation _fadeAnimation;

  AuthBloc _authBloc;
  bool expanded = false;

  @override
  void initState() {
    _controller = AnimationController(
        duration: widget.loginAnimationDuration, vsync: this);
    _fadeAnimation = Tween(begin: 0.0, end: 1.0).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void didChangeDependencies() {
    super.didChangeDependencies();
    _authBloc = WasteagramStateContainer.of(context).blocProvider.authBloc;
  }

  Widget _buildLoginButton() {
    return FlatButton(
      onPressed: _authBloc.signInWithGoogle,
      child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
        Padding(
          padding: EdgeInsets.all(AppPadding.p4),
          child: Icon(Icons.account_circle),
        ),
        Text(
          'Login',
          style: TextStyle(
              fontSize: AppFonts.h5,
              color: Theme.of(context).primaryColorLight),
        ),
      ]),
    );
  }

  Widget _buildLogoutButton(String email) {
    return Stack(fit: StackFit.expand, children: [
      Container(
        alignment: Alignment.topRight,
        child: GestureDetector(
          onTap: () => setState(() {
            if (expanded) {
              _controller..reverse();
              Future.delayed(widget.loginAnimationDuration)
                  .then((e) => expanded = !expanded);
            } else {
              _controller..forward();
              expanded = !expanded;
            }
          }),
          child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
            Padding(
              padding: EdgeInsets.fromLTRB(
                  AppPadding.p0, AppPadding.p0, AppPadding.p4, AppPadding.p0),
              child: expanded
                  ? Icon(Icons.arrow_drop_up)
                  : Icon(Icons.arrow_drop_down),
            ),
            Text(
              email,
              overflow: TextOverflow.fade,
              softWrap: false,
              style: TextStyle(
                  fontSize: AppFonts.h8,
                  color: Theme.of(context).primaryColorLight),
            ),
          ]),
        ),
      ),
      Visibility(
        visible: expanded,
        child: PositionedTransition(
          rect: RelativeRectTween(
            begin: RelativeRect.fromLTRB(0, 0, 0, 0),
            end: RelativeRect.fromLTRB(0, AppFonts.h4, 0, 0),
          ).animate(
              CurvedAnimation(parent: _controller, curve: Curves.easeOut)),
          child: Container(
            alignment: Alignment.topRight,
            child: GestureDetector(
              onTap: _authBloc.logout,
              child: FadeTransition(
                // visible: expanded,
                opacity: _fadeAnimation,
                child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(AppPadding.p0, AppPadding.p0,
                        AppPadding.p4, AppPadding.p0),
                    child: Icon(Icons.account_circle),
                  ),
                  Text(
                    'Logout',
                    overflow: TextOverflow.fade,
                    softWrap: false,
                    style: TextStyle(
                        fontSize: AppFonts.h8,
                        color: Theme.of(context).primaryColorLight),
                  ),
                ]),
              ),
            ),
          ),
        ),
      ),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _authBloc.authStatus,
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
              return Padding(
                  padding: EdgeInsets.fromLTRB(AppPadding.p0, AppPadding.p4,
                      AppPadding.p0, AppPadding.p1),
                  child: _buildLoginButton());
            }
            return _buildLogoutButton(snapshot.data.email);
          default:
            return Text('default');
        }
      },
    );
  }
}
