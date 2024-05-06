import 'package:flutter_bloc/flutter_bloc.dart';

class PageCubit extends Cubit<double> {
  PageCubit() : super(0);

  void previousPage() => emit(state - 1);
  void nextPage() => emit(state + 1);
}
