import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:myworking_app/Screens/Auth/login.dart';
import 'package:myworking_app/SplashScreen.dart';
import 'package:myworking_app/homescreen.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SplashScreen(),
    );
  }
}
