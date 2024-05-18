import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../Login/login_pages.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final User? user = ModalRoute.of(context)!.settings.arguments as User?;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            if (user != null && user.photoURL != null)
              CircleAvatar(
                backgroundImage: NetworkImage(user.photoURL!),
                radius: 50,
              ),
            const SizedBox(height: 20),
            if (user != null)
              Text(
                'Name: ${user.displayName}',
                style: const TextStyle(fontSize: 20),
              ),
            const SizedBox(height: 10),
            if (user != null)
              Text(
                'Email: ${user.email}',
                style: const TextStyle(fontSize: 20),
              ),
            const SizedBox(height: 10),
            if (user != null)
              Text(
                'UID: ${user.uid}',
                style: const TextStyle(fontSize: 20),
              ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                // Đăng xuất Firebase
                await FirebaseAuth.instance.signOut();
                // Đăng xuất Google Sign-In
                await GoogleSignIn().signOut();
                // Chuyển hướng về trang đăng nhập
                Navigator.pushReplacementNamed(context, '/login');
              },
              child: const Text('Sign Out'),
            ),
          ],
        ),
      ),
    );
  }
}
