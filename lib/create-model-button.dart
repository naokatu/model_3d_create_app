import 'package:flutter/material.dart';

class CreateModelButton extends StatelessWidget {
  final int photoCount;
  final VoidCallback onPressed;

  const CreateModelButton({
    super.key,
    required this.photoCount,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      right: 10,
      bottom: 35,
      child: ElevatedButton(
        onPressed: photoCount >= 1 ? onPressed : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: photoCount >= 1 ? Colors.blue : Colors.grey,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        ),
        child: const Text('3Dモデルを作る'),
      ),
    );
  }
}
