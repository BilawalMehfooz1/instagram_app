//packages import
import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:instagram_app/Screens/auth_screens/login_screen.dart';

//local imports
import 'package:flutter/material.dart';
import 'package:instagram_app/data/colors.dart';
import 'package:instagram_app/Screens/screen_dimension/screen_dimension.dart';
import 'package:instagram_app/Screens/screen_dimension/web_screen.dart';
import 'package:instagram_app/Screens/screen_dimension/mobile_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Instagram Clone',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: mobileBackgroundColor,
      ),
      home: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            if (snapshot.hasData) {
              return const Scaffold(
                body: ScreenDimension(
                  webScreenLayout: WebScreen(),
                  mobileScreenLayout: MobileScreen(),
                ),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text('${snapshot.error}'),
              );
            }
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(color: primaryColor),
            );
          }
          return const LoginScreen();
        },
      ),
    );
  }
}
