import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../utils/next_screen.dart';
import '../../utils/utils.dart';
import '../auth/login_Email_Password.dart';

class PostScreen extends StatefulWidget {
  const PostScreen({super.key});
  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  final auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.cyanAccent.shade700,
        centerTitle: true,
        title: const Text(
          "Post",
          style: TextStyle(fontSize: 25, color: Colors.white),
        ),
        actions: [
          IconButton(
              onPressed: () {
                auth.signOut().then((value) {
                  nextScreen(context, const LoginEmailAndPassword());
                }).onError((error, stackTrace) {
                  Utils().toastMessage(error.toString());
                });
              },
              icon: const Icon(
                Icons.logout_outlined,
                size: 30,
                color: Colors.white,
              ))
        ],
      ),
    );
  }
}
