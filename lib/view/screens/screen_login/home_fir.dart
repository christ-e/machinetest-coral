import 'package:cart_coral_machinetest/database/firebase_db.dart';
import 'package:cart_coral_machinetest/view/screens/screen_login/login_fir.dart';
import 'package:flutter/material.dart';

class Home_fire extends StatelessWidget {
  const Home_fire({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: Center(
        child: ElevatedButton(
            onPressed: () {
              FirebaseHelper().signOut().then((result) => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoginScreen())));
            },
            child: Text('sign out')),
      ),
    );
  }
}
