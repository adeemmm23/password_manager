import 'package:flutter_bloc/flutter_bloc.dart';

class PageCubit extends Cubit<double> {
  PageCubit() : super(0);

  void nextPage() => emit(1);
}
