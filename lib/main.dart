import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'router.dart';

bool pinLock = false;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    systemNavigationBarColor: Colors.transparent,
  ));
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    late final appRouter = AppRouter();

    return MaterialApp.router(
      title: 'Lock',
      debugShowCheckedModeBanner: false,
      themeAnimationCurve: Curves.easeInOut,
      theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
        brightness: Brightness.light,
        seedColor: Colors.green.shade500,
      )),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        colorScheme: ColorScheme.fromSeed(
          brightness: Brightness.dark,
          seedColor: Colors.green.shade500,
        ),
      ),
      themeMode: ThemeMode.system,
      routeInformationParser: appRouter.router.routeInformationParser,
      routeInformationProvider: appRouter.router.routeInformationProvider,
      routerDelegate: appRouter.router.routerDelegate,
    );
  }
}
