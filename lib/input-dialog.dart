import 'package:flutter/material.dart';

class InputDialog extends StatefulWidget {
  final String title;
  final String hintText;

  const InputDialog({super.key, required this.title, required this.hintText});

  @override
  State<InputDialog> createState() => _InputDialogState();
}

class _InputDialogState extends State<InputDialog> {
  final TextEditingController _textFieldController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.title),
      content: TextField(
        controller: _textFieldController,
        decoration: InputDecoration(hintText: widget.hintText),
      ),
      actions: <Widget>[
        TextButton(
          child: const Text('キャンセル'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        TextButton(
          child: const Text('決定'),
          onPressed: () {
            // 入力された文字列をcreateModelPageへ
            Navigator.of(context).pop(_textFieldController.text);
          },
        ),
      ],
    );
  }

  @override
  void dispose() {
    _textFieldController.dispose();
    super.dispose();
  }
}
