import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'global/bloc/color_bloc.dart';
import 'global/constants.dart';
import 'global/bloc/theme_bloc.dart';
import 'router.dart';

void main() async {
  // Ensure that Flutter is initialized
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  final prefs = await SharedPreferences.getInstance();

  final isLocked = prefs.getBool('pinLock') ?? false;
  final appRouter = AppRouter(isLocked);

  final theme = prefs.getInt('theme') ?? 0;
  final themeCubit = ThemeCubit(theme);

  final color = prefs.getInt('color') ?? 0;
  final colorCubit = ColorCubit(color);

  // prefs.remove('passwords');
  // prefs.remove('pinLock');
  // prefs.remove('theme');
  // prefs.remove('color');

  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    systemNavigationBarColor: Colors.transparent,
  ));

  runApp(MainApp(
    appRouter: appRouter,
    themeCubit: themeCubit,
    colorCubit: colorCubit,
  ));
}

class MainApp extends StatelessWidget {
  const MainApp({
    super.key,
    required this.appRouter,
    required this.themeCubit,
    required this.colorCubit,
  });

  final AppRouter appRouter;
  final ThemeCubit themeCubit;
  final ColorCubit colorCubit;

  @override
  Widget build(BuildContext context) {
    const pageTransition = PageTransitionsTheme(
      builders: {
        TargetPlatform.android: CupertinoPageTransitionsBuilder(),
        TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
      },
    );
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: themeCubit),
        BlocProvider.value(value: colorCubit),
      ],
      child: BlocBuilder<ColorCubit, Color>(
        builder: (context, color) {
          return BlocBuilder<ThemeCubit, ThemeMode>(
              builder: (context, themeMode) {
            return MaterialApp.router(
              title: 'Lock',
              debugShowCheckedModeBanner: false,
              themeAnimationCurve: Curves.easeInOut,
              theme: ThemeData(
                  pageTransitionsTheme: pageTransition,
                  colorScheme: ColorScheme.fromSeed(
                    brightness: Brightness.light,
                    seedColor: color,
                  )),
              darkTheme: ThemeData(
                pageTransitionsTheme: pageTransition,
                colorScheme: ColorScheme.fromSeed(
                  brightness: Brightness.dark,
                  seedColor: color,
                ),
              ),
              themeMode: themeMode,
              routeInformationParser: appRouter.router.routeInformationParser,
              routeInformationProvider:
                  appRouter.router.routeInformationProvider,
              routerDelegate: appRouter.router.routerDelegate,
            );
          });
        },
      ),
    );
  }
}
