import 'package:e_commerce_app/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier {
  AppUser _user = AppUser(
    id: '',
    name: '',
    email: '',
    password: '',
    address: '',
    type: '',
    token: '',
    cart: [],
  );

  AppUser get user => _user;

  void setUser(String userJson) {
    _user = AppUser.fromJson(userJson);
    notifyListeners();
  }

  void setUserFromModel(AppUser user) {
    _user = user;
    notifyListeners();
  }

  void setUserf(User firebaseUser) {
    print("Setting user with ID: ${firebaseUser.uid}");
    _user = AppUser(
      id: firebaseUser.uid,
      name: firebaseUser.displayName ?? '',
      email: firebaseUser.email ?? '',
      password: '', // We don't store the password
      address: '',
      type: '',
      token:
          '', // You might want to use firebaseUser.getIdToken() here if needed
      cart: [],
    );
    notifyListeners();
    print("User set successfully: ${_user.email}");
  }

  void setUserf1(AppUser user) {
    _user = user;
    notifyListeners();
  }

  Future<void> fetchUserData(String userId) async {
    try {
      DatabaseReference userRef =
          FirebaseDatabase.instance.ref().child('users').child(userId);
      DataSnapshot snapshot = await userRef.get();

      if (snapshot.exists) {
        Map<String, dynamic> data = snapshot.value as Map<String, dynamic>;
        print("Fetched user data: $data"); // Debug print

        // Create a new AppUser with the fetched data
        AppUser user = AppUser(
          id: userId,
          name: data['name'] ?? '',
          email: data['email'] ?? '',
          password: '', // Don't store the password
          address: data['address'] ?? '',
          type: data['type'] ?? '',
          token: data['token'] ?? '',
          cart: (data['cart'] as List<dynamic>?) ?? [],
        );

        setUserf1(user); // Use setUserf1 to set the fetched user data
      } else {
        print('User data does not exist in the database.');
      }
    } catch (e) {
      print('Error fetching user data: ${e.toString()}');
    }
  }
}
