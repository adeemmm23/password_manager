import 'package:flutter_bloc/flutter_bloc.dart';

class PageCubit extends Cubit<PageState> {
  PageCubit() : super(PageState.current);

  void previousPage() => emit(PageState.previous);
  void nextPage() => emit(PageState.next);
  void currentPage() => emit(PageState.current);
}

enum PageState { current, previous, next }
