import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:password_manager/home/home.dart';

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
    return MaterialApp(
      title: 'Lock',
      debugShowCheckedModeBanner: false,
      themeAnimationCurve: Curves.easeInOut,
      theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
        brightness: Brightness.light,
        seedColor: Colors.orange.shade700,
      )),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        colorScheme: ColorScheme.fromSeed(
          brightness: Brightness.dark,
          seedColor: Colors.orange.shade700,
        ),
      ),
      themeMode: ThemeMode.dark,
      home: const Home(),
    );
  }
}
