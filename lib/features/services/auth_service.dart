import 'dart:convert';

import 'package:e_commerce_app/constants/error_handling.dart';
import 'package:e_commerce_app/constants/global_variables.dart';
import 'package:e_commerce_app/constants/utils.dart';
import 'package:e_commerce_app/features/home/screens/home_screen.dart';
import 'package:e_commerce_app/features/widgets/bottom_bar.dart';
import 'package:e_commerce_app/models/user.dart';
import 'package:e_commerce_app/providers/user_provider.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  //sign up user
  final FirebaseAuth _auth = FirebaseAuth.instance;

  void signUpUser({
    required BuildContext context,
    required String email,
    required String password,
    required String name,
  }) async {
    try {
      AppUser user = AppUser(
        id: '',
        name: name,
        email: email,
        password: password,
        address: '',
        type: '',
        token: '',
        cart: [],
      );

      http.Response res = await http.post(Uri.parse('$uri/api/signup'),
          body: user.toJson(),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          });

      httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () {
            showSnackBar(context,
                "Account has been created please login with ur credentials");
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  //login user
  void signInUser({
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    try {
      http.Response res = await http.post(Uri.parse('$uri/api/signin'),
          body: jsonEncode({'email': email, 'password': password}),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          });

      httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () async {
            SharedPreferences prefs = await SharedPreferences.getInstance();
            Provider.of<UserProvider>(context, listen: false).setUser(res.body);
            await prefs.setString(
                'x-auth-token', jsonDecode(res.body)['token']);
            Navigator.pushNamedAndRemoveUntil(
                context, BottomBar.routeName, (route) => false);
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  //get user data
  // get user data
  void getUserData(
    BuildContext context,
  ) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('x-auth-token');

      if (token == null) {
        prefs.setString('x-auth-token', '');
      }

      var tokenRes = await http.post(
        Uri.parse('$uri/tokenIsValid'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': token!
        },
      );

      var response = jsonDecode(tokenRes.body);

      if (response == true) {
        http.Response userRes = await http.get(
          Uri.parse('$uri/'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'x-auth-token': token
          },
        );

        var userProvider = Provider.of<UserProvider>(context, listen: false);
        userProvider.setUser(userRes.body);
      }
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  //get user data using firebase

  // Sign in user with Firebase
  void signInUserf({
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    try {
      print("Attempting to sign in with email: $email");
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      User? firebaseUser = userCredential.user;

      if (firebaseUser != null) {
        print("Successfully signed in. User ID: ${firebaseUser.uid}");

        // Store the user in the provider
        Provider.of<UserProvider>(context, listen: false)
            .setUserf(firebaseUser);

        // Fetch additional user data from Firebase Realtime Database if needed
        await Provider.of<UserProvider>(context, listen: false)
            .fetchUserData(firebaseUser.uid);

        // Navigate to the home screen
        Navigator.pushNamedAndRemoveUntil(
            context, BottomBar.routeName, (route) => false);
      } else {
        print("User is null after sign in");
        showSnackBar(context, 'Failed to sign in. Please try again.');
      }
    } on FirebaseAuthException catch (e) {
      print("FirebaseAuthException: ${e.code} - ${e.message}");
      if (e.code == 'user-not-found') {
        showSnackBar(context, 'No user found for that email.');
      } else if (e.code == 'wrong-password') {
        showSnackBar(context, 'Wrong password provided for that user.');
      } else {
        showSnackBar(context, 'Authentication error: ${e.message}');
      }
    } catch (e) {
      print("Unexpected error: ${e.toString()}");
      showSnackBar(context, 'Error: ${e.toString()}');
    }
  }

  void signUpUserF({
    required BuildContext context,
    required String email,
    required String password,
    required String name,
  }) async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      User? user = userCredential.user;

      if (user != null) {
        // You can update additional user information here if needed
        await user.updateProfile(displayName: name);

        // Optionally, you can save additional user details to Firebase Realtime Database
        DatabaseReference userRef =
            FirebaseDatabase.instance.ref().child('users').child(user.uid);
        await userRef.set({
          'name': name,
          'email': email,
          'address': '',
          'type': '',
          'token': '',
          'cart': [],
        });

        showSnackBar(context,
            "Account has been created, please log in with your credentials");
      }
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }
}
