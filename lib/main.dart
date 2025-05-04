import 'package:flutter/material.dart';
import 'package:passei/screens/home_page.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:passei/themes/theme_manager.dart';
import 'package:passei/themes/app_themes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final sharedPreferences = await SharedPreferences.getInstance();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(
    ChangeNotifierProvider(
      create: (_) => ThemeManager(sharedPreferences)..loadThemePreference(),
      child: const Passei(),
    ),
  );
}

class Passei extends StatelessWidget {
  const Passei({super.key});

  @override
  Widget build(BuildContext context) {
    final themeManager = Provider.of<ThemeManager>(context);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppThemes.lightTheme,
      darkTheme: AppThemes.darkTheme,
      themeMode: themeManager.themeMode,
      home: const HomePage(),
    );
  }
}
