import 'package:flutter/material.dart';
import 'package:instagram_app/data/colors.dart';
import 'package:instagram_app/resources/auth_method.dart';
import 'package:instagram_app/widgets/text_field_input.dart';
import 'package:instagram_app/resources/error_messages.dart';
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
  bool _isFirstDialog = false;
  bool _isSecondDialog = false;
  var _passwordVisibility = true;
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  //To check either email and password field is empty or not
  @override
  void initState() {
    super.initState();
    _emailController.addListener(() {
      if (_emailController.text.isNotEmpty) {
        setState(() {
          _isFirstDialog = true;
        });
      } else {
        setState(() {
          _isFirstDialog = false;
        });
      }
    });
    _passwordController.addListener(() {
      if (_passwordController.text.isNotEmpty) {
        setState(() {
          _isSecondDialog = true;
        });
      } else {
        setState(() {
          _isSecondDialog = false;
        });
      }
    });
  }

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
          ScaffoldMessenger.of(context).clearSnackBars();
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
                  labelText: 'Enter your email',
                  keyboardType: TextInputType.emailAddress,
                  textEditingController: _emailController,
                  isFocusedCallback: updateIsTextFocused,
                  icon: _isFirstDialog ? Icons.clear : null,
                  onPressed: () {
                    _emailController.clear();
                  },
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      if (!_isFirstDialog) {
                        showAlertDialog(
                          title: 'Email required',
                          content: 'Enter your email to continue.',
                          buttonText: 'OK',
                          context: context,
                        );
                      }
                      return null;
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
                  icon: _isSecondDialog
                      ? _passwordVisibility
                          ? Icons.visibility_off
                          : Icons.visibility
                      : null,
                  obscureText: _passwordVisibility,
                  onPressed: () {
                    setState(() {
                      _passwordVisibility = !_passwordVisibility;
                    });
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      if (_isFirstDialog && !_isSecondDialog) {
                        showAlertDialog(
                          title: 'Password required',
                          content: 'Enter your password to continue.',
                          buttonText: 'OK',
                          context: context,
                        );
                      }
                      return null;
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
                    onTap: _isLoading
                        ? null
                        : () {
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
                      child: const Text(
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
