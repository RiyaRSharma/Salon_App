import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../screens/home_page.dart';
import '../screens/login_page.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Widget handleAuthState() {
    return StreamBuilder<User?>(
      stream: _auth.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator()); // ✅ Show loading indicator
        } else if (snapshot.hasData) {
          return const HomePage();
        } else {
          return const LoginPage();
        }
      },
    );
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }
}
