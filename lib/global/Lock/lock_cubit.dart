import 'package:flutter_bloc/flutter_bloc.dart';

class LockCubit extends Cubit<bool> {
  LockCubit() : super(false);

  void toogleLock(bool value) {
    emit(value);
  }
}
