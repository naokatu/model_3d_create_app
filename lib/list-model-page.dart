import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import './select-button.dart';

class ListModelPage extends StatefulWidget {
  const ListModelPage({super.key});

  @override
  State<ListModelPage> createState() => _ListModelPage();
}

class _ListModelPage extends State<ListModelPage> {
  List<String> _models = [];
  @override
  void initState() {
    super.initState();
    _loadModels();
  }

  Future<void> _loadModels() async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final file = File('${directory.path}/url/models.txt');
      if (await file.exists()) {
        List<String> lines = await file.readAsLines();
        List<String> fileNames = lines.map((url) => url.split('/').last).toList();

        setState(() {
          _models = fileNames;
        });
      } else {
        print('models.txt file does not exist');
      }
    } catch (e) {
      print('Error loading models: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: _models.length,
      itemBuilder: (context, index) {
        return SelectButton(
          buttonText: _models[index],
          iconPath: null, // 画像はなし
          nextPage: '/model-detail',
        );
      },
    );
  }
}
