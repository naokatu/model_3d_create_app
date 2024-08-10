import 'package:flutter/material.dart';

class DimensionInputDialog extends StatelessWidget {
  final String title;

  const DimensionInputDialog({required this.title, super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController widthController = TextEditingController();
    final TextEditingController heightController = TextEditingController();
    final TextEditingController lengthController = TextEditingController();

    return AlertDialog(
      title: Text(title),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: widthController,
            decoration: const InputDecoration(hintText: '横の長さ'),
            keyboardType: TextInputType.number,
          ),
          TextField(
            controller: lengthController,
            decoration: const InputDecoration(hintText: '縦の長さ'),
            keyboardType: TextInputType.number,
          ),
          TextField(
            controller: heightController,
            decoration: const InputDecoration(hintText: '高さ'),
            keyboardType: TextInputType.number,
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(null);
          },
          child: const Text('キャンセル'),
        ),
        TextButton(
          onPressed: () async {
            await Future.delayed(const Duration(seconds: 2));

            final dimensions = {
              'width': double.tryParse(widthController.text) ?? 0,
              'length': double.tryParse(lengthController.text) ?? 0,
              'height': double.tryParse(heightController.text) ?? 0,
            };
            Navigator.of(context).pop(dimensions);
          },
          child: const Text('OK'),
        ),
      ],
    );
  }
}
