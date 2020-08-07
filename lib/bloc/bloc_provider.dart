import 'package:flutter/foundation.dart';
import 'package:wasteagram/bloc/waste_bloc.dart';

class BlocProvider {
  final WasteBloc wasteBloc;
  BlocProvider({@required this.wasteBloc});
}
