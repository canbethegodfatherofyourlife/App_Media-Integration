import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/first_screen.dart';
import 'package:flutter_app/login_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SocialMediaAuth',
      theme: ThemeData.light(),
      home: FirebaseAuth.instance.currentUser != null
          ? FirstScreen()
          : LoginPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
