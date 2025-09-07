import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'global/state/color_bloc.dart';
import 'global/constants.dart';
import 'global/state/theme_bloc.dart';
import 'router.dart';
import 'features/home/views/passwords/state/passwords_bloc.dart';

void main() async {
  // Ensure that Flutter is initialized
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  final appRouter = AppRouter();
  final passwordsCubit = PasswordsCubit();
  final prefs = await SharedPreferences.getInstance();

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
    appRouter,
    themeCubit,
    colorCubit,
    passwordsCubit,
  ));
}

class MainApp extends StatelessWidget {
  const MainApp(
    this.appRouter,
    this.themeCubit,
    this.colorCubit,
    this.passwordsCubit, {
    super.key,
  });

  final ThemeCubit themeCubit;
  final ColorCubit colorCubit;
  final AppRouter appRouter;
  final PasswordsCubit passwordsCubit;

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
        BlocProvider.value(value: passwordsCubit),
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
                brightness: Brightness.light,
                pageTransitionsTheme: pageTransition,
                colorSchemeSeed: color,
              ),
              darkTheme: ThemeData(
                brightness: Brightness.dark,
                pageTransitionsTheme: pageTransition,
                colorSchemeSeed: color,
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
