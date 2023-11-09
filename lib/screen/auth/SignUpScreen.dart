import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_project1/utils/next_screen.dart';
import 'package:firebase_project1/utils/utils.dart';
import 'package:firebase_project1/widget/RoundTextField.dart';
import 'package:firebase_project1/widget/round_button.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import 'login_Email_Password.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});
  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool loading = false;
  final _formField = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  FocusNode fieldemail = FocusNode();
  FocusNode fieldpassword = FocusNode();
  FirebaseAuth _auth = FirebaseAuth.instance;
  bool isShow = true;
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.cyanAccent.shade700,
        centerTitle: true,
        title: const Text(
          "Sign Up",
          style: TextStyle(fontSize: 25, color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            Lottie.asset(
              "assets/Sign up.json",
              width: 250,
              height: 250,
            ),
            Form(
              key: _formField,
              child: Column(
                children: [
                  RoundTextField(
                    obscureText: false,
                    focusNode: fieldemail,
                    onFieldSubmitted: (value) {
                      FocusScope.of(context).requestFocus(fieldpassword);
                    },
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    hintText: "Enter Your Email",
                    helperText: "enter email e.g join@gmail.com",
                    prefixIcon: const Icon(Icons.alternate_email),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Enter Your Email Again";
                      }
                      bool emailValid =
                          RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                              .hasMatch(value);
                      if (!emailValid) {
                        return "Enter Valid Email";
                      }
                    },
                  ),
                  const SizedBox(height: 15),
                  RoundTextField(
                    obscureText: isShow,
                    prefixIcon: const Icon(Icons.password),
                    controller: passwordController,
                    keyboardType: TextInputType.visiblePassword,
                    hintText: "Enter Your Password",
                    focusNode: fieldpassword,
                    right: IconButton(
                      onPressed: () {
                        setState(() {
                          isShow = !isShow;
                        });
                      },
                      icon: Icon(
                        isShow ? Icons.visibility_off : Icons.visibility,
                        color: Colors.black,
                      ),
                    ),
                    helperText: "enter password *************",
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Enter Your Password Again";
                      } else if (passwordController.text.length < 6) {
                        return "Password length Should not be more than 6 characters";
                      }
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 15),
            RoundButton(
                title: "Sign Up",
                loading: loading,
                onPressed: () {
                  if (_formField.currentState!.validate()) {
                    setState(() {
                      loading = true;
                    });
                    _auth
                        .createUserWithEmailAndPassword(
                            email: emailController.text.toString(),
                            password: passwordController.text.toString())
                        .then((value) {
                      setState(() {
                        loading = false;
                      });
                    }).onError((error, stackTrace) {
                      Utils().toastMessage(error.toString());
                      setState(() {
                        loading = false;
                      });
                    });
                  }
                }),
            const SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Already have an account?"),
                TextButton(
                    onPressed: () {
                      nextScreen(context, const LoginEmailAndPassword());
                    },
                    child: const Text('Log In'))
              ],
            )
          ],
        ),
      ),
    );
  }
}
