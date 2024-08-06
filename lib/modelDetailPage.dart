import 'package:flutter/material.dart';

class ModelDetailPage extends StatefulWidget {
  final String content;
  const ModelDetailPage({super.key, required this.content});

  @override
  State<ModelDetailPage> createState() => _ModelDetailPage();
}

class _ModelDetailPage extends State<ModelDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
           '${widget.content}から遷移されました',
          ),
        ],
      ),
    );
  }
}
