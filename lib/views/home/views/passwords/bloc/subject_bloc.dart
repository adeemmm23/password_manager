import 'package:flutter_bloc/flutter_bloc.dart';

class SubjectCubit extends Cubit<int> {
  SubjectCubit() : super(0);

  void addOne() => emit(state + 1);
}
