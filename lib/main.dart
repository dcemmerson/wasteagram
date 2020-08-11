/// filename: main.dart
/// last modified: 08/07/2020
/// description: Entry point to wasteagram app
/// Note: The structure and organization of this app is largely inspired by
///   Eric Windmill's ecommerce app, found
///   https://github.com/ericwindmill/flutter_in_action_source_code/tree/master/chapter_7-8-9/e_commerce

import 'package:flutter/material.dart';
import 'package:wasteagram/app.dart';
import 'package:wasteagram/bloc/bloc_provider.dart';
import 'package:wasteagram/bloc/waste_bloc.dart';
import 'package:wasteagram/bloc/wasteagram_state.dart';
import 'package:wasteagram/services/network/waste_service.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  var wasteService = WasteService();
  var wasteBloc = WasteBloc(wasteService);

  runApp(WasteagramStateContainer(
      blocProvider: BlocProvider(wasteBloc: wasteBloc),
      child: WasteagramApp()));
}
