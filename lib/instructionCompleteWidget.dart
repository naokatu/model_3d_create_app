import 'package:flutter/material.dart';

class InstructionCompleteWidget extends StatelessWidget {
  const InstructionCompleteWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.all(16),
        color: Colors.black.withOpacity(0.7),
        child: const Text(
          '撮影完了！\n右下の3Dモデル作成ボタンを押して下さい！',
          style: TextStyle(color: Colors.white, fontSize: 20),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}