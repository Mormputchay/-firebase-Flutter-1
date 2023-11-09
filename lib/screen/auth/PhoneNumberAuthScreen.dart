import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class PhoneNumberAuthScreen extends StatefulWidget {
  const PhoneNumberAuthScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _PhoneNumberAuthScreenState createState() => _PhoneNumberAuthScreenState();
}

class _PhoneNumberAuthScreenState extends State<PhoneNumberAuthScreen> {
  final TextEditingController _phoneNumberController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Phone Number Authentication'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _phoneNumberController,
              keyboardType: TextInputType.phone,
              decoration: const InputDecoration(
                labelText: 'Phone Number',
              ),
            ),
            const SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () => _verifyPhoneNumber(context),
              child: const Text('Verify Phone Number'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _verifyPhoneNumber(BuildContext context) async {
    String phoneNumber = "+85512345678";

    log("sdlkskdskdsskd ${phoneNumber}");
    await _auth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: (PhoneAuthCredential credential) async {
        await _auth.signInWithCredential(credential);
        Navigator.pushReplacementNamed(context, '/home');
      },
      verificationFailed: (FirebaseAuthException e) {
        print(e.message);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text('Verification failed. Please try again.')),
        );
      },
      codeSent: (String verificationId, int? resendToken) {
        Navigator.pushNamed(
          context,
          '/otp',
          arguments: {
            'verificationId': verificationId,
          },
        );
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  }
}
