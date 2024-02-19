import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:myworking_app/Screens/Auth/login.dart';
import 'package:myworking_app/Screens/screens/splash_screen.dart';
import 'package:myworking_app/Screens/screens/homeScreen.dart';
import 'package:sizer/sizer.dart';

import 'Screens/Auth/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await SizerUtil();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FlutterSizer(builder: (context, orientation, screenType) {
      return MaterialApp(
        home: LoginScreen(),
      );
    });
  }
}
