import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../widgets/custom_button.dart';
import '../widgets/custom_text_field.dart';

class RegisterPage extends StatelessWidget {
  RegisterPage({super.key});

  static String id = 'RegisterPage';

  String? email;
  String? password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      // appBar: AppBar(
      //   title: const Text(
      //     'Login',
      //     style: TextStyle(color: Colors.white, fontSize: 30),
      //   ),
      //   centerTitle: true,
      // ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          //crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Spacer(
              flex: 2,
            ),
            Image.asset("assets/images/scholar.png"),
            const Text(
              'Scholar Chat',
              style: TextStyle(
                  color: Colors.white, fontSize: 30, fontFamily: 'Pacifico'),
            ),
            const Spacer(
              flex: 2,
            ),
            const Row(
              children: [
                Text(
                  'Register',
                  style: TextStyle(color: Colors.white, fontSize: 30),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            CustomTextField(
              labelText: 'Email',
              onChanged: (data) {
                email = data;
              },
            ),
            const SizedBox(
              height: 10,
            ),
            CustomTextField(
              labelText: 'Password',
              onChanged: (data) {
                password = data;
              },
            ),
            const SizedBox(
              height: 20,
            ),
            CustomButton(
              onTap: () async {
                try {
                  await registerUser();
                } on FirebaseAuthException catch (ex) {
                  if (ex.code == 'weak-password') {
                    showSnackBar(context,
                        message: 'The password provided is too weak.');
                  } else if (ex.code == 'email-already-in-use') {
                    showSnackBar(context,
                        message: 'The account already exists for that email.');
                  } else if (ex.code == 'invalid-email') {
                    showSnackBar(context,
                        message: 'The email address is not valid.');
                  }
                }
                showSnackBar(context, message: 'User registered successfully');
              },
              text: 'Register',
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Already have an account?',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text(
                    'Login',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                )
              ],
            ),
            const Spacer(
              flex: 3,
            )
          ],
        ),
      ),
    );
  }

  void showSnackBar(BuildContext context, {required String message}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  Future<void> registerUser() async {
    FirebaseAuth.instance;
    UserCredential userCredential = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email!, password: password!);
    print(userCredential.user!.displayName);
  }
}
