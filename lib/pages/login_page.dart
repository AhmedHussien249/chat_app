import 'package:flutter/material.dart';

import '../widgets/custom_button.dart';
import '../widgets/custom_text_field.dart';
import 'register_page.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

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
            Spacer(
              flex: 2,
            ),
            Image.asset("assets/images/scholar.png"),
            Text(
              'Scholar Chat',
              style: TextStyle(color: Colors.white, fontSize: 30),
            ),
            Spacer(
              flex: 2,
            ),
            Row(
              children: [
                Text(
                  'Login',
                  style: TextStyle(color: Colors.white, fontSize: 30),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            CustomTextField(labelText: 'Email'),
            SizedBox(
              height: 10,
            ),
            CustomTextField(labelText: 'Password'),
            SizedBox(
              height: 20,
            ),
            CustomButton(text: 'Login',),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Don\'t have an account?',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => RegisterPage(),
                      ),
                    );
                  },
                  child: const Text(
                    'Register',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                )
              ],
            ),
            Spacer(
              flex: 3,
            )
          ],
        ),
      ),
    );
  }
}
