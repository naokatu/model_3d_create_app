import 'package:flutter/material.dart';
import 'package:hack_3d_create_app/list-model-button.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

class ListModelPage extends StatefulWidget {
  const ListModelPage({super.key});

  @override
  State<ListModelPage> createState() => _ListModelPage();
}

class _ListModelPage extends State<ListModelPage> {
  List<String> _modelNames = [];
  List<String> _modelUrls = [];
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
        List<String> fileNames = lines.map((url) => Uri.decodeComponent(url.split('/').last.split('.').first)).toList();

        setState(() {
          _modelUrls = lines;
          _modelNames = fileNames;
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
      itemCount: _modelNames.length,
      itemBuilder: (context, index) {
        return ListModelButton(
          buttonText: _modelNames[index],
          url: _modelUrls[index],
        );
      },
    );
  }
}
