import 'package:flutter/material.dart';
import 'package:instagram_app/data/colors.dart';
import 'package:instagram_app/resources/auth_method.dart';
import 'package:instagram_app/widgets/text_field_input.dart';
import 'package:instagram_app/resources/snackbar_function.dart';
import 'package:instagram_app/Screens/screen_dimension/web_screen.dart';
import 'package:instagram_app/Screens/auth_screens/sign_up_screen.dart';
import 'package:instagram_app/Screens/screen_dimension/mobile_screen.dart';
import 'package:instagram_app/Screens/screen_dimension/screen_dimension.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var _isLoading = false;
  bool isTextFocused = false;
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  // Function to dissapear thing when text field is opened
  void updateIsTextFocused(bool isFocused) {
    setState(() {
      isTextFocused = isFocused;
    });
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
          padding: const EdgeInsets.symmetric(horizontal: 20),
          width: double.infinity,
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Visibility(
                  visible: !isTextFocused,
                  child: TextButton(
                    onPressed: () {},
                    child: const Text(
                      'English (US)',
                      style: TextStyle(
                        color: secondaryColor,
                      ),
                    ),
                  ),
                ),
                const Spacer(),
                //svg logo image
                Image.asset(
                  'assets/images/instagram.png',
                  height: 75,
                ),
                const Spacer(),

                //email text field
                TextFieldInput(
                  labelText: 'Username, email or mobile number',
                  keyboardType: TextInputType.emailAddress,
                  textEditingController: _emailController,
                  isFocusedCallback: updateIsTextFocused,
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
                  labelText: 'Password',
                  textEditingController: _passwordController,
                  isFocusedCallback: updateIsTextFocused,
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
                      borderRadius: BorderRadius.all(Radius.circular(25)),
                      color: blueColor,
                    ),
                    child: _isLoading
                        ? const CircularProgressIndicator(color: primaryColor)
                        : const Text(
                            'Log in',
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                  ),
                ),
                const Spacer(flex: 2),

                //switch to sign up
                Visibility(
                  visible: !isTextFocused,
                  child: InkWell(
                    onTap: () {
                      switchToSignUp();
                    },
                    child: Container(
                      width: double.infinity,
                      alignment: Alignment.center,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: blueColor,
                          width: 2,
                        ),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(25)),
                        color: Colors.transparent,
                      ),
                      child: _isLoading
                          ? const CircularProgressIndicator(color: primaryColor)
                          : const Text(
                              'Create new account',
                              style: TextStyle(
                                color: blueColor,
                                fontSize: 16,
                              ),
                            ),
                    ),
                  ),
                ),
                const SizedBox(height: 4),

                //Meta Logo
                Visibility(
                  visible: !isTextFocused,
                  child: Image.asset(
                    'assets/images/meta.png',
                    height: 50,
                    color: primaryColor,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
