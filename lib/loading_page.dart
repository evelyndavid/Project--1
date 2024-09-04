import 'package:flutter/material.dart';

class LoadingPage extends StatelessWidget {
  const LoadingPage({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.of(context).pushReplacementNamed('/trips');
    });

    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Text(
          'Smart Bag Inventory',
          style: TextStyle(
            fontSize: 24,
            color: Colors.yellow,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
