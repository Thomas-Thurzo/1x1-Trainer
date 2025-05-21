import 'package:ein_mal_eins_app/screens/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(
    MaterialApp(
      home: MainScreen(),
      debugShowCheckedModeBanner: false,
      title: '1x1 App',
    ),
  );
}
