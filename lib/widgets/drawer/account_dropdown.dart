import 'package:flutter/material.dart';
import 'package:wasteagram/bloc/auth_bloc.dart';
import 'package:wasteagram/bloc/wasteagram_state.dart';
import 'package:wasteagram/routes/routes.dart';
import 'package:wasteagram/styles/styles.dart';

class LoginButton extends StatefulWidget {
  final loggedInAnimationDuration = const Duration(milliseconds: 250);
  final loggedOutAnimationDuration = const Duration(milliseconds: 100);
  final _circularProgressIndicator =
      Container(width: 20, height: 20, child: CircularProgressIndicator());

  final _dropdownItemInsets = EdgeInsets.fromLTRB(
      AppPadding.p4, AppPadding.p0, AppPadding.p0, AppPadding.p0);

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
  bool _isLoggedIn = false;

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

  void _signIn() async {
    setState(() => _waitingForServer = true);
    await _authBloc.signIn(LoginType.Gmail);
    setState(() {
      _waitingForServer = false;
      _willBeAnimated = false;
    });
    _loggedInController..reverse();
  }

  void _logout() async {
    setState(() => _waitingForServer = true);
    await _authBloc.logout();

    setState(() {
      _waitingForServer = false;
      _willBeAnimated = true;
    });

    _loggedInController..forward();
  }

  void _goToAccountSettings() {
    Routes.accountPage(context);
  }

  void _expandLogoutDropdown() {
    if (_expanded) {
      _loggedOutController..reverse();
      Future.delayed(widget.loggedInAnimationDuration)
          .then((e) => setState(() => _expanded = !_expanded));
    } else {
      _loggedOutController..forward();
      setState(() => _expanded = !_expanded);
    }
  }

  Widget _loading() {
    return Container(
        alignment: Alignment.topRight, child: CircularProgressIndicator());
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
            onTap: _signIn,
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

  Widget _tappableEmailDropdown(String email) {
    return Container(
      alignment: Alignment.topRight,
      child: GestureDetector(
        onTap: _expandLogoutDropdown,
        child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
          Flexible(
              child: Text(
            email,
            overflow: TextOverflow.fade,
            softWrap: false,
            style: TextStyle(
                fontSize: AppFonts.h8,
                color: Theme.of(context).primaryColorLight),
          )),
          Padding(
            padding: EdgeInsets.fromLTRB(
                AppPadding.p4, AppPadding.p0, AppPadding.p0, AppPadding.p0),
            child: _expanded
                ? Icon(Icons.arrow_drop_up)
                : Icon(Icons.arrow_drop_down),
          ),
        ]),
      ),
    );
  }

  Widget _goToAccountSettingsButton({double dropdownDistance: AppFonts.h4}) {
    return Visibility(
      visible: _expanded,
      child: PositionedTransition(
        rect: RelativeRectTween(
          begin: RelativeRect.fromLTRB(0, 0, 0, 0),
          end: RelativeRect.fromLTRB(0, dropdownDistance, 0, 0),
        ).animate(CurvedAnimation(
            parent: _loggedOutController, curve: Curves.easeOut)),
        child: Container(
          alignment: Alignment.topRight,
          child: GestureDetector(
            onTap: _goToAccountSettings,
            child: FadeTransition(
              opacity: _fadeAnimation,
              child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                Text(
                  'Account',
                  overflow: TextOverflow.fade,
                  softWrap: false,
                  style: TextStyle(
                      fontSize: AppFonts.h8,
                      color: Theme.of(context).primaryColorLight),
                ),
                Padding(
                  padding: widget._dropdownItemInsets,
                  child: _waitingForServer
                      ? widget._circularProgressIndicator
                      : Icon(Icons.account_circle),
                ),
              ]),
            ),
          ),
        ),
      ),
    );
  }

  Widget _switchAccountButton({double dropdownDistance: 2 * AppFonts.h4}) {
    return Visibility(
      visible: _expanded,
      child: PositionedTransition(
        rect: RelativeRectTween(
          begin: RelativeRect.fromLTRB(0, 0, 0, 0),
          end: RelativeRect.fromLTRB(0, dropdownDistance, 0, 0),
        ).animate(CurvedAnimation(
            parent: _loggedOutController, curve: Curves.easeOut)),
        child: Container(
          alignment: Alignment.topRight,
          child: GestureDetector(
            onTap: _waitingForServer ? null : _logout,
            child: FadeTransition(
              // visible: expanded,
              opacity: _fadeAnimation,
              child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                Text(
                  'Logout',
                  overflow: TextOverflow.fade,
                  softWrap: false,
                  style: TextStyle(
                      fontSize: AppFonts.h8,
                      color: Theme.of(context).primaryColorLight),
                ),
                Padding(
                  padding: widget._dropdownItemInsets,
                  child: _waitingForServer
                      ? widget._circularProgressIndicator
                      : Icon(Icons.arrow_forward),
                ),
              ]),
            ),
          ),
        ),
      ),
    );
  }

  Widget _logoutButton({double dropdownDistance: 2 * AppFonts.h4}) {
    return Visibility(
      visible: _expanded,
      child: PositionedTransition(
        rect: RelativeRectTween(
          begin: RelativeRect.fromLTRB(0, 0, 0, 0),
          end: RelativeRect.fromLTRB(0, dropdownDistance, 0, 0),
        ).animate(CurvedAnimation(
            parent: _loggedOutController, curve: Curves.easeOut)),
        child: Container(
          alignment: Alignment.topRight,
          child: GestureDetector(
            onTap: _waitingForServer ? null : _logout,
            child: FadeTransition(
              // visible: expanded,
              opacity: _fadeAnimation,
              child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                Text(
                  'Logout',
                  overflow: TextOverflow.fade,
                  softWrap: false,
                  style: TextStyle(
                      fontSize: AppFonts.h8,
                      color: Theme.of(context).primaryColorLight),
                ),
                Padding(
                  padding: widget._dropdownItemInsets,
                  child: _waitingForServer
                      ? widget._circularProgressIndicator
                      : Icon(Icons.arrow_forward),
                ),
              ]),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLoggedInDropdown(String email) {
    return Stack(fit: StackFit.expand, children: [
      _tappableEmailDropdown(email),
      _goToAccountSettingsButton(dropdownDistance: AppFonts.h4),
      _logoutButton(dropdownDistance: 2 * AppFonts.h4),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _authBloc.user.first,
      builder: (context, snapshot) {
        if (snapshot.hasError) return Text('Something unexpected occurred');
        switch (snapshot.connectionState) {
          case ConnectionState.done:
            if (snapshot.hasData && snapshot.data.email != null) {
              return _buildLoggedInDropdown(snapshot.data.email);
            }
            return _buildLoginButton();
          case ConnectionState.waiting:
          case ConnectionState.active:
            return _buildLoginButton();
          case ConnectionState.none:
          default:
            return _loading();
        }
      },
    );
  }
}
