import 'package:flutter_bloc/flutter_bloc.dart';

class PageCubit extends Cubit<int?> {
  PageCubit() : super(null);

  void nextPage() => emit(1);
}
