import 'package:flutter/material.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({super.key});

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          const DrawerHeader(
            child: Center(
              child: Text(
                'Dish3D',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ),
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
          ),
          const Divider(
            thickness: 1.0,
            color: Colors.black,
          ),
          //画面遷移を行うボタン名と移動先を必要に応じて記述
          listTile('ホーム', Icons.home, context, '/'),
          listTile('作成者用', Icons.create, context, '/creator'),
          listTile('3Dモデル表示', Icons.qr_code_scanner, context, '/qr'),
          listTile('3Dモデル作成', Icons.camera_alt, context, '/create-model'),
          listTile('3Dモデル確認', Icons.folder, context, '/list'),
        ],
      ),
    );
  }

  // コンポーネント
  Widget listTile(String title, IconData icon, BuildContext context, String route) {
    return ListTile(
      leading: Icon(icon),
      title: Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 20.0,
        ),
      ),
      trailing: const Icon(Icons.arrow_circle_right),
      onTap: () {
        Navigator.pop(context); // Drawerを閉じる
        Navigator.pushNamed(context, route); // 指定したルートに遷移
      },
    );
  }
}
