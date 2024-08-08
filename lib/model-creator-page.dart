import 'package:flutter/material.dart';
import './select-button.dart';

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
          SelectButton(
              buttonText: '3Dモデル作成',
              iconPath: 'images/カメラアイコン.png',
              nextPage: '/create-model'),
          SelectButton(
              buttonText: '3Dモデル確認',
              iconPath: 'images/お皿アイコン.png',
              nextPage: '/list')
        ],
      ),
    );
  }
}
