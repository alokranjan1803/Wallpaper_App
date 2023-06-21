import 'package:flutter/material.dart';
import 'package:wallpaper_app/views/screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Wallpaper Pexel',
      theme: ThemeData(
        primarySwatch: Colors.blue,

      ),
      home:  const HomeScreen(),
    );
  }
}
