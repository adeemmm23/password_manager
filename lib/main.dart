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

  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    systemNavigationBarColor: Colors.transparent,
  ));
  runApp(MainApp(appRouter));
}

class MainApp extends StatelessWidget {
  const MainApp(
    this.appRouter, {
    super.key,
  });

  final AppRouter appRouter;
  @override
  Widget build(BuildContext context) {
    debugPrint("Building MainApp");

    return BlocProvider(
      create: (context) => ThemeCubit(),
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
