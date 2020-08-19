import 'package:flutter/material.dart';
import 'package:wasteagram/bloc/auth_bloc.dart';
import 'package:wasteagram/bloc/wasteagram_state.dart';
import 'package:wasteagram/styles/styles.dart';

class LoginButton extends StatefulWidget {
  final loggedInAnimationDuration = const Duration(milliseconds: 150);
  final loggedOutAnimationDuration = const Duration(milliseconds: 75);
  final _circularProgressIndicator =
      Container(width: 20, height: 20, child: CircularProgressIndicator());

  @override
  _LoginButtonState createState() => _LoginButtonState();
}

class _LoginButtonState extends State<LoginButton>
    with TickerProviderStateMixin {
  // Keep these controllers separate, otherwise we're bound to cause an issue.
  AnimationController _loggedOutController;
  AnimationController _loggedInController;

  Animation _fadeAnimation;

  AuthBloc _authBloc;
  bool _expanded = false;
  bool _waitingForServer = false;
  bool _willBeAnimated = false;

  @override
  void initState() {
    super.initState();
    _loggedOutController = AnimationController(
        duration: widget.loggedInAnimationDuration, vsync: this);
    _loggedInController = AnimationController(
        duration: widget.loggedOutAnimationDuration, vsync: this);
    _fadeAnimation = Tween(begin: 0.0, end: 1.0).animate(_loggedOutController);
  }

  @override
  void dispose() {
    _loggedOutController.dispose();
    _loggedInController.dispose();
    super.dispose();
  }

  void didChangeDependencies() {
    super.didChangeDependencies();
    _authBloc = WasteagramStateContainer.of(context).blocProvider.authBloc;
  }

  void signIn() async {
    setState(() => _waitingForServer = true);
    await _authBloc.signInWithGoogle();
    setState(() {
      _waitingForServer = false;
      _willBeAnimated = false;
    });
    _loggedInController..reverse();
  }

  void logout() async {
    setState(() => _waitingForServer = true);
    await _authBloc.logout();

    setState(() {
      _waitingForServer = false;
      _willBeAnimated = true;
    });

    _loggedInController..forward();
  }

  void expandLogoutDropdown() {
    if (_expanded) {
      _loggedOutController..reverse();
      Future.delayed(widget.loggedInAnimationDuration)
          .then((e) => setState(() => _expanded = !_expanded));
    } else {
      _loggedOutController..forward();
      setState(() => _expanded = !_expanded);
    }
  }

  Widget _buildLoginButton() {
    return Stack(fit: StackFit.expand, children: [
      PositionedTransition(
        rect: RelativeRectTween(
          begin:
              RelativeRect.fromLTRB(0, _willBeAnimated ? AppFonts.h4 : 0, 0, 0),
          end: RelativeRect.fromLTRB(0, 0, 0, 0),
        ).animate(CurvedAnimation(
            parent: _loggedInController, curve: Curves.easeOut)),
        child: Container(
          alignment: Alignment.topRight,
          child: GestureDetector(
            onTap: signIn,
            child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
              Padding(
                padding: EdgeInsets.fromLTRB(
                    AppPadding.p0, AppPadding.p0, AppPadding.p4, AppPadding.p0),
                child: _waitingForServer
                    ? widget._circularProgressIndicator
                    : Icon(Icons.account_circle),
              ),
              Text(
                'Login',
                style: TextStyle(
                    fontSize: AppFonts.h6,
                    color: Theme.of(context).primaryColorLight),
              ),
            ]),
          ),
        ),
      )
    ]);
  }

  Widget _buildLogoutButton(String email) {
    return Stack(fit: StackFit.expand, children: [
      Container(
        alignment: Alignment.topRight,
        child: GestureDetector(
          onTap: expandLogoutDropdown,
          child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
            Padding(
              padding: EdgeInsets.fromLTRB(
                  AppPadding.p0, AppPadding.p0, AppPadding.p4, AppPadding.p0),
              child: _expanded
                  ? Icon(Icons.arrow_drop_up)
                  : Icon(Icons.arrow_drop_down),
            ),
            Flexible(
                child: Text(
              email,
              overflow: TextOverflow.fade,
              softWrap: false,
              style: TextStyle(
                  fontSize: AppFonts.h8,
                  color: Theme.of(context).primaryColorLight),
            )),
          ]),
        ),
      ),
      Visibility(
        visible: _expanded,
        child: PositionedTransition(
          rect: RelativeRectTween(
            begin: RelativeRect.fromLTRB(0, 0, 0, 0),
            end: RelativeRect.fromLTRB(0, AppFonts.h4, 0, 0),
          ).animate(CurvedAnimation(
              parent: _loggedOutController, curve: Curves.easeOut)),
          child: Container(
            alignment: Alignment.topRight,
            child: GestureDetector(
              onTap: _waitingForServer ? null : logout,
              child: FadeTransition(
                // visible: expanded,
                opacity: _fadeAnimation,
                child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(AppPadding.p0, AppPadding.p0,
                        AppPadding.p4, AppPadding.p0),
                    child: _waitingForServer
                        ? widget._circularProgressIndicator
                        : Icon(Icons.account_circle),
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
              return _buildLoginButton();
            }
            return _buildLogoutButton(snapshot.data.email);
          default:
            return Text('default');
        }
      },
    );
  }
}
