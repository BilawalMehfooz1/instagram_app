import 'package:flutter/material.dart';
import 'package:instagram_app/Screens/sign_up_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({
    super.key,
    required this.webScreenLayout,
    required this.mobileScreenLayout,
  });

  final Widget webScreenLayout;
  final Widget mobileScreenLayout;

  @override
  Widget build(BuildContext context) {
    return const SignupScreen();
    // return LayoutBuilder(
    //   builder: (context, constraints) {
    //     if (constraints.maxWidth > webScreenSize) {
    //       return webScreenLayout;
    //     }
    //     return mobileScreenLayout;
    //   },
    // );
  }
}
