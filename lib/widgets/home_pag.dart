import 'package:flutter/material.dart';

class HomePag extends StatelessWidget {
  const HomePag({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        centerTitle: true,
        title: Text(
          'Home Page',
          style: TextStyle(fontSize: 50, color: Colors.red),
        ),
      ),
    );
  }
}
