import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'router.dart';

bool pinLock = false;
ThemeMode isDark = ThemeMode.system;
final dotenv = DotEnv();

class ThemeManager extends ChangeNotifier {
  Future<void> savePreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isDark', isDark == ThemeMode.dark);
  }

  toggleThemeMode(value) {
    isDark = value;
    notifyListeners();
    savePreferences();
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  pinLock = prefs.getBool('pinLock') ?? false;
  isDark = prefs.getBool('isDark') == true ? ThemeMode.dark : ThemeMode.system;
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    systemNavigationBarColor: Colors.transparent,
  ));

  await dotenv.load(fileName: ".env");
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  runApp(const MainApp());
}

final themeManager = ThemeManager();
final appRouter = AppRouter();

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: themeManager,
        builder: (context, child) {
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
            themeMode: isDark,
            routeInformationParser: appRouter.router.routeInformationParser,
            routeInformationProvider: appRouter.router.routeInformationProvider,
            routerDelegate: appRouter.router.routerDelegate,
          );
        });
  }
}
