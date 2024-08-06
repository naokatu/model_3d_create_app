import 'package:flutter/material.dart';

class ListModelPage extends StatefulWidget {
  const ListModelPage({super.key});

  @override
  State<ListModelPage> createState() => _ListModelPage();
}

class _ListModelPage extends State<ListModelPage> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text('作成したモデルを一覧表示するページです')
        ],
      ),
    );
  }
}
