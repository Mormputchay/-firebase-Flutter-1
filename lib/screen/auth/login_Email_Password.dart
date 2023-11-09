import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_project1/screen/auth/Reset_Password.dart';
import 'package:firebase_project1/screen/auth/SignUpScreen.dart';
import 'package:firebase_project1/utils/next_screen.dart';
import 'package:firebase_project1/utils/utils.dart';
import 'package:firebase_project1/widget/RoundTextField.dart';
import 'package:firebase_project1/widget/round_button.dart';
import 'package:flutter/material.dart';

import '../post/post.dart';

class LoginEmailAndPassword extends StatefulWidget {
  const LoginEmailAndPassword({super.key});
  @override
  State<LoginEmailAndPassword> createState() => _LoginEmailAndPasswordState();
}

class _LoginEmailAndPasswordState extends State<LoginEmailAndPassword> {
  bool loading = false;
  final _formField = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  FocusNode fieldemail = FocusNode();
  FocusNode fieldpassword = FocusNode();
  final _auth = FirebaseAuth.instance;

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
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.blueAccent,
        title: const Text('Login Email and Password'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Form(
          key: _formField,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
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
              const SizedBox(height: 15),
              RoundButton(
                  title: "Login",
                  loading: loading,
                  onPressed: () {
                    if (_formField.currentState!.validate()) {
                      login();
                    }
                  }),
              const SizedBox(height: 15),
              GestureDetector(
                onTap: () {
                  nextScreen(context, const ForgetPassword());
                },
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      "ForgetPassword",
                      style: TextStyle(
                          decoration: TextDecoration.underline,
                          color: Colors.pink),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 15),
              MaterialButton(
                shape: RoundedRectangleBorder(
                    side: const BorderSide(color: Colors.black, width: 1),
                    borderRadius: BorderRadius.circular(15)),
                minWidth: double.maxFinite,
                height: 50,
                child: const Text('Login with Phone',
                    style: TextStyle(fontSize: 16, color: Colors.black)),
                onPressed: () {},
              ),
              const SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Don't have an account?"),
                  TextButton(
                      onPressed: () {
                        nextScreen(context, const SignUpScreen());
                      },
                      child: const Text('Sign Up'))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  void login() {
    _auth
        .signInWithEmailAndPassword(
            email: emailController.text.toString(),
            password: passwordController.text.toString())
        .then((value) {
      Utils().toastMessage(value.user!.email.toString());
      nextScreenReplace(context, const PostScreen());
      setState(() {
        loading = false;
      });
    }).onError((error, stackTrace) {
      debugPrint(error.toString());
      Utils().toastMessage(error.toString());
      setState(() {
        loading = false;
      });
    });
    setState(() {
      loading = true;
    });
  }
}
