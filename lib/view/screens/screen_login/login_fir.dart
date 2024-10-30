import 'package:cart_coral_machinetest/database/firebase_db.dart';
import 'package:cart_coral_machinetest/view/screens/screen_home/homescreen.dart';
import 'package:cart_coral_machinetest/view/screens/screen_login/reg_fir.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'home_fir.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyB72b4fFPaPHbqijCPzc4Eo58HD8etkbJ4",
      projectId: "stellar-display-398208",
      appId: '1:792857541724:android:448991ff3571f9ce9cfa99',
      messagingSenderId: '',
    ),
  );
  //currently login user kittaan
  User? user = FirebaseAuth.instance.currentUser;
  runApp(MaterialApp(
    home: user == null ? LoginScreen() : Home_fire(),
  ));
}

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final username_controller = TextEditingController();
  final password_controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Log in'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextField(
              decoration: InputDecoration(
                  border: OutlineInputBorder(), hintText: 'username'),
              controller: username_controller,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextField(
              decoration: InputDecoration(
                  border: OutlineInputBorder(), hintText: 'password'),
              controller: password_controller,
            ),
          ),
          ElevatedButton(
              onPressed: () {
                String email = username_controller.text.trim();
                String pass = password_controller.text.trim();

                FirebaseHelper()
                    .login(
                  email: email,
                  password: pass,
                )
                    .then((result) {
                  if (result == null) {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => HomeScreen()));
                  } else {
                    ScaffoldMessenger.of(context)
                        .showSnackBar(SnackBar(content: Text(result)));
                  }
                });
              },
              child: Text('Login')),
          SizedBox(
            height: 15,
          ),
          TextButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => RegistrationScreen()));
              },
              child: Text('Register'))
        ],
      ),
    );
  }
}
