import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    serverClientId: '955836907761-18nd5dsnid4cuqfkaorl9l24bk8vut77.apps.googleusercontent.com',
  ); //cái này chuyền vào từ google-sevices.json đấy lấy clientId

  Future<User?> _signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        print('User cancelled the sign-in');
        return null;
      }
      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      print('Access Token: ${googleAuth.accessToken}');
      print('ID Token: ${googleAuth.idToken}');
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      final UserCredential userCredential = await _auth.signInWithCredential(credential);
      final User? user = userCredential.user;
      if (user != null) {
        print('User: ${user.displayName}');
        print('Email: ${user.email}');
        print('UID: ${user.uid}');
        Navigator.pushReplacementNamed(context, '/profile', arguments: user);
      }
      return user;
    } catch (e) {
      print('Error signing in: $e');
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login Page'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            User? user = await _signInWithGoogle();
            if (user != null) {
              Navigator.pushReplacementNamed(context, '/profile', arguments: user);
            }
          },
          child: const Text('Sign in with Google'),
        ),
      ),
    );
  }
}
