import 'package:flutter/material.dart';
import 'package:instagram_app/data/colors.dart';
import 'package:instagram_app/Screens/home_screen.dart';
import 'package:instagram_app/Screens/web_screen.dart';
import 'package:instagram_app/Screens/mobile_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData.dark().copyWith(
          scaffoldBackgroundColor: mobileBackgroundColor,
        ),
        home: const Scaffold(
          body: HomeScreen(
            webScreenLayout: WebScreen(),
            mobileScreenLayout: MobileScreen(),
          ),
        ));
  }
}
