import 'package:cart_coral_machinetest/model/model_Cart.dart';
import 'package:cart_coral_machinetest/view/screens/screen_home/homescreen.dart';
import 'package:cart_coral_machinetest/view/screens/screen_login/login_fir.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';

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
  await Hive.initFlutter();
  Hive.registerAdapter(CartItemAdapter());
  await Hive.openBox<CartItem>('cartBox');
  // runApp(const MyApp());
  User? user = FirebaseAuth.instance.currentUser;
  runApp(MaterialApp(
    home: user == null ? LoginScreen() : HomeScreen(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginScreen(),
    );
  }
}
