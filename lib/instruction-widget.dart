import 'package:flutter/material.dart';

class InstructionWidget extends StatelessWidget {
  final String instruction;

  const InstructionWidget({super.key, required this.instruction});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 40,
      left: 0,
      right: 0,
      child: Container(
        padding: const EdgeInsets.all(8),
        color: Colors.black.withOpacity(0.5),
        child: Text(
          instruction,
          style: const TextStyle(color: Colors.white, fontSize: 18),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
