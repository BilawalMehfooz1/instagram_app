import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:instagram_app/resources/snackbar_function.dart';

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  //sign up user
  Future<String> signUpUser({
    required String email,
    required String password,
    required String username,
    required String fullname,
    required ScaffoldMessengerState scaffoldMessengerState,
  }) async {
    String res = 'Some error occured';
    try {
      if (email.isNotEmpty ||
          password.isEmpty ||
          username.isNotEmpty ||
          fullname.isNotEmpty) {
        // register user
        UserCredential cred = await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );
        // add user to database
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
    } on FirebaseAuthException catch (error) {
      res = error.toString();

      showSnackBar(
        content: res,
        scaffoldMessengerState: scaffoldMessengerState,
      );
    }
    return res;
  }
}
