import 'package:flutter/material.dart';

class TitleScreen extends StatelessWidget {
  final VoidCallback onTouch;

  const TitleScreen({super.key, required this.onTouch});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTouch,
      child: Container(
        color: Colors.black87,
        child: Center(
          child: Text(
            'ProjectGiulietto',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.greenAccent,
            ),
          ),
        ),
      ),
    );
  }
}
