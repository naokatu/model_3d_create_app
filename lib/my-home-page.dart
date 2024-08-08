import 'package:flutter/material.dart';
import './select-button.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({ super.key });

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SelectButton(buttonText: '作成者用', iconPath: 'images/ロボットアームのアイコン.png', nextPage: '/creator'),
          SelectButton(buttonText: '3Dモデル表示', iconPath: 'images/QR.png', nextPage: '/qr')
        ],
      ),
    );
  }
}
