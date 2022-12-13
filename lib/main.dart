import 'package:flutter/material.dart';
import 'package:food_app/screens/login_screen.dart';
import 'package:food_app/screens/splash_screen.dart';
import 'package:get/get.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Food',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      home: LoginScreen(),
    );
  }
}
