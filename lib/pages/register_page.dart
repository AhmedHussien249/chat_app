import 'package:chat_app/pages/register_cubit/register_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../helper/show_snack_bar.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_text_field.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  static String id = 'RegisterPage';

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  String? email;

  String? password;

  bool isLoading = false;

  GlobalKey<FormState> formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return BlocListener<RegisterCubit, RegisterState>(
      listener: (context, state) {
        if (state is RegisterLoading) {
          isLoading = true;
        } else if (state is RegisterSuccess) {
          isLoading = false;
          Navigator.pushNamed(context, 'ChatPage', arguments: email);
        } else if (state is RegisterFailure) {
          isLoading = false;
          showSnackBar(context, message: state.errorMessage);
        }
      },
      child: ModalProgressHUD(
        inAsyncCall: isLoading,
        progressIndicator: const CircularProgressIndicator(),
        child: Scaffold(
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
            child: Form(
              key: formKey,
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
                        color: Colors.white,
                        fontSize: 30,
                        fontFamily: 'Pacifico'),
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
                  CustomFormTextField(
                    labelText: 'Email',
                    onChanged: (data) {
                      email = data;
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomFormTextField(
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
                      if (formKey.currentState!.validate()) {
                        BlocProvider.of<RegisterCubit>(context, listen: false)
                            .registerUser(email: email!, password: password!);
                      }
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
          ),
        ),
      ),
    );
  }
}
