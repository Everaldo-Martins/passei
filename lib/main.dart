import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:passei/screens/home_page.dart';

void main() {
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(const Passei());
}

class Passei extends StatelessWidget {
  const Passei({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}
