import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'global/theme/theme_cubit.dart';
import 'router.dart';

final dotenv = DotEnv();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  final lock = prefs.getBool('pinLock') ?? false;
  await dotenv.load(fileName: ".env");

  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    systemNavigationBarColor: Colors.transparent,
  ));
  runApp(MainApp(lock: lock));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key, required this.lock});

  final bool lock;

  @override
  Widget build(BuildContext context) {
    final appRouter = AppRouter(lock: lock);

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
