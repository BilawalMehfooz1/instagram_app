import 'package:flutter/material.dart';
import 'package:instagram_app/Screens/home_screen.dart';

class ScreenDimension extends StatelessWidget {
  const ScreenDimension({
    super.key,
    required this.webScreenLayout,
    required this.mobileScreenLayout,
  });

  final Widget webScreenLayout;
  final Widget mobileScreenLayout;

  @override
  Widget build(BuildContext context) {
    return const HomeScreen();
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
