import 'package:flutter/material.dart';
import 'package:hack_3d_create_app/qrReaderPage.dart';
import './modelCreatorPage.dart';
import './header.dart';
import './myHomePage.dart';
import './customDrawer.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: '3D-create-app',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF1A237E)),
          scaffoldBackgroundColor: const Color(0xFFFFF5F0),
          useMaterial3: true,
        ),
        initialRoute: '/',
        routes: <String, WidgetBuilder>{
          '/': (context) => const MainScreen(title: 'ホーム', child: MyHomePage(),isHome: true),
          '/creator': (context) => const MainScreen(title: '作成者用', child: ModelCreatorPage(),isHome: false),
          '/qr': (context) => const MainScreen(title: 'QR読み取り', child: QrReaderPage(),isHome: false)
        },
    );
  }
}

class MainScreen extends StatelessWidget {
  const MainScreen({
    super.key,
    required this.title,
    required this.child,
    required this.isHome,
  });

  final String title;
  final Widget child;
  final bool isHome;

  @override
  Widget build(BuildContext context) {
   return Scaffold(
     appBar: Header(title: title,isHome: isHome),
     drawer: const CustomDrawer(),
     body: child,
   );
  }
}


