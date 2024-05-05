import 'package:flutter_bloc/flutter_bloc.dart';

class ControllerCubit extends Cubit<String> {
  ControllerCubit() : super("");

  void update(String value) => emit(value);
}
