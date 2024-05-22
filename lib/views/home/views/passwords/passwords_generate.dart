import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'passwords_generate_views/bloc/page_bloc.dart';
import 'passwords_generate_views/bloc/controller_bloc.dart';
import 'passwords_generate_views/select_password.dart';
import 'passwords_generate_views/select_website.dart';
import '../../../../components/expandable_pageview.dart';

class PasswordGenerate extends StatelessWidget {
  const PasswordGenerate({super.key});

  @override
  Widget build(BuildContext context) {
    final pageController = PageController();
    final controllerCubit = ControllerCubit();
    final pageCubit = PageCubit();

    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: controllerCubit),
        BlocProvider.value(value: pageCubit),
      ],
      child: BlocBuilder<PageCubit, PageState>(
        buildWhen: (previous, current) => pageController.hasClients,
        builder: (context, state) {
          if (state != PageState.current) {
            pageController.animateToPage(
              state == PageState.next ? 1 : 0,
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
            );
            context.read<PageCubit>().currentPage();
          }
          return Padding(
            padding: EdgeInsets.only(
              right: 15,
              left: 15,
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: ExpandablePageView(
              pageController: pageController,
              children: const [
                SelectWebsite(), // First Page
                SavePassword(), // Second Page
              ],
            ),
          );
        },
      ),
    );
  }
}
