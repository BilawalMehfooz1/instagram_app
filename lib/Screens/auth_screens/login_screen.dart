import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:instagram_app/Screens/auth_screens/sign_up_screen.dart';
import 'package:instagram_app/data/colors.dart';
import 'package:instagram_app/resources/auth_method.dart';
import 'package:instagram_app/widgets/text_field_input.dart';
import 'package:instagram_app/resources/snackbar_function.dart';
import 'package:instagram_app/Screens/screen_dimension/web_screen.dart';
import 'package:instagram_app/Screens/screen_dimension/mobile_screen.dart';
import 'package:instagram_app/Screens/screen_dimension/screen_dimension.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var _isLoading = false;
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  // Login user method
  void logIn() async {
    FocusScope.of(context).unfocus();
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });
      final res = await AuthMethods().logInUser(
        email: _emailController.text,
        password: _passwordController.text,
      );
      setState(() {
        _isLoading = false;
      });

      // error messages
      if (res == 'Success') {
        if (!mounted) {
          return;
        }
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => const ScreenDimension(
              webScreenLayout: WebScreen(),
              mobileScreenLayout: MobileScreen(),
            ),
          ),
        );
      } else {
        if (mounted) {
          showSnackBar(content: res, context: context);
        }
      }
    }
  }

  // Switch to Sign up method
  void switchToSignUp() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => const SignupScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        width: double.infinity,
        child: Form(
          key: _formKey,
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

              //email text field
              TextFieldInput(
                hintText: 'Enter your email',
                keyboardType: TextInputType.emailAddress,
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

              //password text field
              TextFieldInput(
                keyboardType: TextInputType.text,
                hintText: 'Enter your password',
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

              //login button
              InkWell(
                onTap: () {
                  logIn();
                },
                child: Container(
                  width: double.infinity,
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(4)),
                    color: blueColor,
                  ),
                  child: _isLoading
                      ? const CircularProgressIndicator(color: primaryColor)
                      : const Text(
                          'Log in',
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
                      "Don't have an account?",
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: _isLoading
                        ? null
                        : () {
                            switchToSignUp;
                          },
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: const Text(
                        " Sign up.",
                        style: TextStyle(
                          fontSize: 16,
                          color: blueColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      )),
    );
  }
}
