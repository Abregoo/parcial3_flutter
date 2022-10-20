import 'package:flutter/material.dart';
import 'package:parcial3app/pages/home_page.dart';

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  int activeTab = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: body());
  }

  BoxDecoration fondo() {
    return BoxDecoration(
        gradient: LinearGradient(
      begin: Alignment.topRight,
      end: Alignment.bottomLeft,
      stops: [
        0.1,
        0.4,
        0.6,
        0.9,
      ],
      colors: [
        Color.fromARGB(255, 31, 30, 22),
        Colors.red,
        Colors.indigo,
        Colors.teal,
      ],
    ));
  }

  

  Widget body() {
    return IndexedStack(
      index: activeTab,
      children: [
        HomePage(),        
      ],
    );
  }
}
