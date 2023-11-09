import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_project1/utils/next_screen.dart';
import 'package:firebase_project1/utils/utils.dart';
import 'package:firebase_project1/widget/round_button.dart';
import 'package:flutter/material.dart';

import '../post/post.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({super.key});
  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailController.dispose();
  }

  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      extendBody: true,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            backReplace(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
        ),
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: const Text(
          'Reset Password',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Center(
              child: Column(
                children: [
                  Image.network(
                    "https://storage.googleapis.com/cms-storage-bucket/50c707a80fe015e19d39.png",
                    width: 250,
                    height: 250,
                    fit: BoxFit.contain,
                  ),
                  const SizedBox(height: 25),
                  const Text(
                    "Receive an email to\nreset your password",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 24,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 15),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    child: Column(
                      children: [
                        TextFormField(
                          controller: emailController,
                          cursorColor: Colors.black,
                          keyboardType: TextInputType.emailAddress,
                          textInputAction: TextInputAction.done,
                          decoration: const InputDecoration(labelText: "Email"),
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Enter Your Email Again";
                            }
                            bool emailValid = RegExp(
                                    r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                .hasMatch(value);
                            if (!emailValid) {
                              return "Enter Valid Email";
                            }
                          },
                        ),
                        const SizedBox(height: 15),
                        RoundButton(
                            title: 'Reset Password',
                            loading: loading,
                            onPressed: () {
                              resetPassword();
                            })
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<void> resetPassword() async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const Center(
              child: CircularProgressIndicator(
                color: Colors.red,
              ),
            ));
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: emailController.text.trim());
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          closeIconColor: Colors.pink,
          content: Text('Password Reset Email Sent')));
      // ignore: use_build_context_synchronously
      Navigator.of(context).popUntil((route) => route.isActive);
      nextScreenReplace(context, PostScreen());
    } on FirebaseAuthException catch (e) {
      Utils().toastMessage(e.toString());
      setState(() {
        loading = false;
      });
      Navigator.of(context).pop();
    }
  }
}
