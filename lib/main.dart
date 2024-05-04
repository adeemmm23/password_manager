import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'global/constants.dart';
import 'global/theme.dart';
import 'router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  final isLocked = prefs.getBool('pinLock') ?? false;
  await dotenv.load(fileName: ".env");
  final appRouter = AppRouter(isLocked: isLocked);
  final themeCubit = ThemeCubit()..initState();

  // empty passwords
  // prefs.remove('passwords');

  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    systemNavigationBarColor: Colors.transparent,
  ));
  runApp(MainApp(
    appRouter: appRouter,
    themeCubit: themeCubit,
  ));
}

class MainApp extends StatelessWidget {
  const MainApp({
    super.key,
    required this.appRouter,
    required this.themeCubit,
  });

  final AppRouter appRouter;
  final ThemeCubit themeCubit;
  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: themeCubit,
      child: BlocBuilder<ThemeCubit, ThemeMode>(
          builder: (context, ThemeMode themeMode) {
        return MaterialApp.router(
          title: 'Lock',
          debugShowCheckedModeBanner: false,
          themeAnimationCurve: Curves.easeInOut,
          theme: ThemeData(
              pageTransitionsTheme: const PageTransitionsTheme(
                builders: {
                  TargetPlatform.android: CupertinoPageTransitionsBuilder(),
                  TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
                },
              ),
              colorScheme: ColorScheme.fromSeed(
                brightness: Brightness.light,
                seedColor: Colors.green.shade500,
              )),
          darkTheme: ThemeData(
            pageTransitionsTheme: const PageTransitionsTheme(
              builders: {
                TargetPlatform.android: CupertinoPageTransitionsBuilder(),
                TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
              },
            ),
            colorScheme: ColorScheme.fromSeed(
              brightness: Brightness.dark,
              seedColor: Colors.green.shade500,
            ),
          ),
          themeMode: themeMode,
          routeInformationParser: appRouter.router.routeInformationParser,
          routeInformationProvider: appRouter.router.routeInformationProvider,
          routerDelegate: appRouter.router.routerDelegate,
        );
      }),
    );
  }
}
