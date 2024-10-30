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
      apiKey: 'AIzaSyBshh6-Zgt0A9EMNMNWciH4m8-R7KySIas',
      appId: '1:662756288481:android:37293def81e6c1e2cc14a0',
      messagingSenderId: '662756288481',
      projectId: 'estore-f2430',
      storageBucket: 'estore-f2430.appspot.com',
    ),
  );

  await Hive.initFlutter();
  Hive.registerAdapter(CartItemAdapter());
  await Hive.openBox<CartItem>('cartBox');
  // runApp(const MyApp());
  User? user = FirebaseAuth.instance.currentUser;
  runApp(GetMaterialApp(
    debugShowCheckedModeBanner: false,
    home: user == null ? const LoginScreen() : HomeScreen(),
  ));
}
