import 'package:flutter/material.dart';
import 'package:lds/src/pages/home/home_page.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Corrigido aqui
      home: HomePage(),
    );
  }
}
