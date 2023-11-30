import 'package:flutter/material.dart';
import '../auth/screens/login.dart';
import '../home/home.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
  static const id = "MyApp";
}

class _MyAppState extends State<MyApp> {
  int selectedCity = 0;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: LoginScreen.id,
      routes: {
        LoginScreen.id: (context) => const LoginScreen(),
        HomePage.id: (context) => const HomePage(),
      },
      theme: ThemeData(fontFamily: 'Lexend'),
    );
  }
}
