import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_project1/splash_screen.dart';
import 'package:flutter/material.dart';

void main() async {
  //initialize the application
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primaryColor: Colors.cyanAccent),
      home: const SplashScreen(),
    );
  }
}
