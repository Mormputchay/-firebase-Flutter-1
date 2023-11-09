import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_project1/screen/auth/login_Email_Password.dart';
import 'package:firebase_project1/screen/post/post.dart';
import 'package:firebase_project1/utils/next_screen.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  SplashService splashService = SplashService();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    splashService.isLogin(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        extendBodyBehindAppBar: true,
        extendBody: true,
        backgroundColor: Colors.cyanAccent.shade700,
        body: Center(
          child: Lottie.asset("assets/flutter.json", width: 300, height: 300),
        ));
  }
}

class SplashService {
  void isLogin(BuildContext context) {
    final auth = FirebaseAuth.instance;
    final user = auth.currentUser;
    if (user != null) {
      Timer(const Duration(seconds: 6),
          () => nextScreenReplace(context, const PostScreen()));
    } else {
      Timer(const Duration(seconds: 6),
          () => nextScreenReplace(context, const LoginEmailAndPassword()));
    }
  }
}
