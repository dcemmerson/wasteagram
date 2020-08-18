import 'package:flutter/foundation.dart';
import 'package:wasteagram/bloc/auth_bloc.dart';
import 'package:wasteagram/bloc/waste_bloc.dart';

class BlocProvider {
  final WasteBloc wasteBloc;
  final AuthBloc authBloc;

  BlocProvider({@required this.wasteBloc, @required this.authBloc});
}
