import 'dart:math';

import 'package:flutter/material.dart';
import 'package:wasteagram/bloc/auth_bloc.dart';
import 'package:wasteagram/bloc/wasteagram_state.dart';
import 'package:wasteagram/styles/styles.dart';

class LoginButtonStandalone extends StatefulWidget {
  static const gridHeight = 50.0;
  final _droppedAnimationDuration = Duration(milliseconds: 2000);

  final _tappableIcons = [
    TappableIcon(
        uri: 'assets/icons/Gmail-128.png',
        loginType: AuthBloc.getLoginType('gmail')),
    TappableIcon(
        uri: 'assets/icons/Github-Flat-48.png',
        loginType: AuthBloc.getLoginType('github')),
    TappableIcon(
        uri: 'assets/icons/facebook.png',
        loginType: AuthBloc.getLoginType('gmail')),
    TappableIcon(
        uri: 'assets/icons/twitter.png',
        loginType: AuthBloc.getLoginType('github')),
    TappableIcon(
        uri: 'assets/icons/apple.png',
        loginType: AuthBloc.getLoginType('gmail')),
  ];

  @override
  _LoginButtonStandaloneState createState() => _LoginButtonStandaloneState();
}

class _LoginButtonStandaloneState extends State<LoginButtonStandalone>
    with TickerProviderStateMixin {
  final Random random = Random();

  AnimationController _controller;
  List<Animation<Offset>> _offsetAnimations;

  AuthBloc _authBloc;
  bool attemptingLogin = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    calculateAnimationDrops();
    _authBloc = WasteagramStateContainer.of(context).blocProvider.authBloc;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void calculateAnimationDrops() {
    final droppedBaseHeight = MediaQuery.of(context).size.height / 100;

    _controller = AnimationController(
        duration: widget._droppedAnimationDuration, vsync: this);

    _offsetAnimations = widget._tappableIcons.map((tappableIcon) {
      final randomDroppedHeight =
          droppedBaseHeight + (droppedBaseHeight * (random.nextInt(100) / 100));
      final animation = Tween<Offset>(
        begin: Offset(0, -randomDroppedHeight),
        end: const Offset(0, 0),
      ).animate(CurvedAnimation(parent: _controller, curve: Curves.bounceOut));
      _controller.forward();
      return animation;
    }).toList();
  }

  void login(LoginType loginType) async {
    setState(() => attemptingLogin = true);
    await _authBloc.signIn(loginType, context: context);
    setState(() => attemptingLogin = false);
  }

  Widget _buildLoginOptions() {
    int index = 0;
    return Container(
      alignment: Alignment.center,
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Padding(
            padding: EdgeInsets.all(AppPadding.p2),
            child: const Text('Choose login method')),
        Wrap(
          children: widget._tappableIcons.map((tappableIcon) {
            index++;
            return SlideTransition(
              position: _offsetAnimations[index - 1],
              child: Container(
                width: 50,
                height: 50,
                child: GestureDetector(
                  onTap: () => login(tappableIcon.loginType),
                  child: Image.asset(tappableIcon.uri),
                ),
                decoration: BoxDecoration(
                    border: Border(
                        bottom:
                            BorderSide(color: Colors.grey.withOpacity(0.5))),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        blurRadius: 5,
                        offset: Offset(0, 5),
                      ),
                    ]),
              ),
            );
          }).toList(),
        ),
      ]),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (attemptingLogin) {
      return Center(child: CircularProgressIndicator());
    } else {
      return _buildLoginOptions();
    }
  }
}

class TappableIcon {
  final String uri;
  final LoginType loginType;

  TappableIcon({
    @required this.uri,
    @required this.loginType,
  });
}
