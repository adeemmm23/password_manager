import 'package:flutter_bloc/flutter_bloc.dart';

class PageCubit extends Cubit<double?> {
  PageCubit() : super(null);

  void previousPage() => emit(0);
  void nextPage() => emit(1);
}
