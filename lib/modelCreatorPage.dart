import 'package:flutter/material.dart';

class ModelCreatorPage extends StatefulWidget {
  const ModelCreatorPage({super.key});

  @override
  State<ModelCreatorPage> createState() => _ModelCreatorPage();
}

class _ModelCreatorPage extends State<ModelCreatorPage> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text('作成者用ページです')
        ],
      ),
    );
  }
}
