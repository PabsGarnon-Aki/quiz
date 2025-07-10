// main.dart

// Importing required Flutter and project files
import 'package:flutter/material.dart';
import 'package:pizza_ulk_practice/pages/home.dart';
import 'package:pizza_ulk_practice/pages/login_page.dart';

// Entry point of the application
void main() {
  runApp(MyApp()); // Runs the root widget of the application
}

// Root widget of the app
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Recip Book', // App name shown in task switcher or system UI
      debugShowCheckedModeBanner: false, // Hides the "debug" banner in debug mode
      theme: ThemeData( // Defines the overall theme settings
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange), // Generates color scheme based on seed
        useMaterial3: true, // Enables Material 3 design system
        appBarTheme: const AppBarTheme( // Customizes appearance of AppBars across the app
          titleTextStyle: TextStyle(
            color: Colors.black, // AppBar title text color
            fontSize: 25, // Font size of AppBar title
            fontWeight: FontWeight.bold, // Font weight of AppBar title
          ),
        ),
      ),
      initialRoute: "/login", // Sets the first route/page shown when the app starts
      routes: { // Defines available named routes in the app
        "/login": (context) => LoginPage(), // Maps '/login' to LoginPage widget
        "/home": (context) => HomePage(), // Maps '/home' to HomePage widget
      },
    );
  }
}
