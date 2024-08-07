import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './selectButton.dart';

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
    _loadmodels();
  }

  void _loadmodels() async {
    //final prefs = await SharedPreferences.getInstance();
    //setState(() {
      //_models = prefs.getStringList('models') ?? [];
    //});
  //}
  // 仮のデータを使用
    setState(() {
      _models = [
        'Astronaut',
        '3D Model 2',
        '3D Model 3',
        '3D Model 4',
        '3D Model 5',
      ];
    });
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
