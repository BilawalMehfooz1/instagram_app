import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:instagram_app/data/colors.dart';
import 'package:instagram_app/resources/auth_method.dart';
import 'package:instagram_app/widgets/text_field_input.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formkey = GlobalKey<FormState>();

  @override
  void dispose() {
    super.dispose();
    _nameController.dispose();
    _emailController.dispose();
    _usernameController.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Center(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 32,
              vertical: 40,
            ),
            width: double.infinity,
            child: Form(
              key: _formkey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  //svg logo image
                  SvgPicture.asset(
                    'assets/images/instagram.svg',
                    height: 64,
                    color: primaryColor,
                  ),
                  const SizedBox(height: 64),

                  //Email text field
                  TextFieldInput(
                    keyboardType: TextInputType.emailAddress,
                    hintText: 'Email',
                    textEditingController: _emailController,
                    validator: (value) {
                      if (value == null ||
                          value.trim().isEmpty ||
                          !value.contains('@')) {
                        return 'invalid email address.';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),

                  //Name text field
                  TextFieldInput(
                    keyboardType: TextInputType.text,
                    hintText: 'Full Name',
                    textEditingController: _nameController,
                    validator: (value) {
                      if (value == null ||
                          value.trim().isEmpty ||
                          value.trim().length < 4) {
                        return 'Full Name should be atleast 4 characters.';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  //email text field
                  TextFieldInput(
                    hintText: 'Username',
                    keyboardType: TextInputType.text,
                    textEditingController: _usernameController,
                    validator: (value) {
                      if (value == null ||
                          value.trim().isEmpty ||
                          value.trim().length < 4) {
                        return 'Username should be atleast 4 characters.';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),

                  //password text field
                  TextFieldInput(
                    keyboardType: TextInputType.text,
                    hintText: 'Password',
                    textEditingController: _passwordController,
                    obscureText: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Password is required.';
                      } else if (value.length < 8) {
                        return 'Password must be at least 8 characters long.';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),

                  //Sign up button
                  InkWell(
                    onTap: () {
                      if (_formkey.currentState!.validate()) {
                        AuthMethods().signUpUser(
                          email: _emailController.text,
                          password: _passwordController.text,
                          username: _usernameController.text,
                          fullname: _nameController.text,
                          scaffoldMessengerState: ScaffoldMessenger.of(context),
                        );
                      }
                    },
                    child: Container(
                      width: double.infinity,
                      alignment: Alignment.center,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(4)),
                        color: blueColor,
                      ),
                      child: const Text(
                        'Sign up',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),

                  //transition to signning up
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: const Text(
                          "Have an account?",
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ),
                      InkWell(
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: const Text(
                            " Log in",
                            style: TextStyle(
                              fontSize: 16,
                              color: blueColor,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      )),
    );
  }
}
