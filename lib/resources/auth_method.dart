import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  //sign up user
  Future<String> signUpUser({
    required String email,
    required String password,
    required String username,
    required String fullname,
  }) async {
    print('signup of auth method is opened');
    String res = 'Some error occurred';
    try {
      if (email.isNotEmpty &&
          password.isNotEmpty &&
          username.isNotEmpty &&
          fullname.isNotEmpty) {
        // Register user
        UserCredential cred = await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );
        print(cred);
        // Add user to the database
        await _firestore.collection('users').doc(cred.user!.uid).set({
          'fullname': fullname,
          'username': username,
          'uid': cred.user!.uid,
          'email': email,
          'followers': [],
          'following': [],
        });
        res = 'Success';
      }
      print('sign up method completed');
    } on FirebaseAuthException catch (error) {
      print('sign up method failed error: $error');
      res =
          error.message.toString(); // Update this line to get the error message
    } catch (e) {
      print('Unknown error: $e');
    }
    print('error message sent');
    return res;
  }

// Login user
  Future<String> loginUser({
    required String email,
    required String password,
    required ScaffoldMessengerState scaffoldMessengerState,
  }) async {
    String res = 'Some error occurred';
    try {
      // login user
      UserCredential cred = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (cred.user != null) {
        res = 'Success';
      } else {
        res = 'User login failed.';
      }
    } on FirebaseAuthException catch (e) {
      res = e.toString();
    }
    return res;
  }
}
