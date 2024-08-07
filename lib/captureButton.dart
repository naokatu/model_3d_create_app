import 'package:flutter/material.dart';

class CaptureButton extends StatelessWidget {
  final VoidCallback onPressed;

  const CaptureButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: GestureDetector(
        onTap: onPressed,
        child: Image.asset(
          'images/カメラ撮影ボタン.png',
          width: 70,
          height: 70,
        ),
      ),
    );
  }
}
