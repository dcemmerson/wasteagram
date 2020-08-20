/// filename: main.dart
/// last modified: 08/07/2020
/// description: Entry point to wasteagram app
/// Note: The structure and organization of this app is largely inspired by
///   Eric Windmill's ecommerce app, found
///   https://github.com/ericwindmill/flutter_in_action_source_code/tree/master/chapter_7-8-9/e_commerce

import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wasteagram/app.dart';
import 'package:wasteagram/bloc/auth_bloc.dart';
import 'package:wasteagram/bloc/bloc_provider.dart';
import 'package:wasteagram/bloc/waste_bloc.dart';
import 'package:wasteagram/bloc/wasteagram_state.dart';
import 'package:wasteagram/services/network/auth_service.dart';
import 'package:wasteagram/services/network/waste_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.portraitUp,
    DeviceOrientation.landscapeRight,
    DeviceOrientation.portraitDown,
  ]);

  final RemoteConfig remoteConfig = await RemoteConfig.instance;
  remoteConfig.setConfigSettings(RemoteConfigSettings(debugMode: true));

  final wasteService = WasteService();
  final wasteBloc = WasteBloc(wasteService);
  final authService = AuthService(remoteConfig: remoteConfig);
  final authBloc = AuthBloc(authService);

  runApp(WasteagramStateContainer(
      blocProvider: BlocProvider(wasteBloc: wasteBloc, authBloc: authBloc),
      child: WasteagramApp()));
}
