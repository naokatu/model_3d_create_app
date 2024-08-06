import 'package:flutter/material.dart';

class CreateModelPage extends StatefulWidget {
  const CreateModelPage({super.key});

  @override
  State<CreateModelPage> createState() => _CreateModelPage();
}

class _CreateModelPage extends State<CreateModelPage> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text('カメラを起動してモデルを作成するページです')
        ],
      ),
    );
  }
}
