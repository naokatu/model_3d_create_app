import 'package:flutter/material.dart';
import 'package:hack_3d_create_app/qr-reader-page.dart';
import './model-creator-page.dart';
import './header.dart';
import './my-home-page.dart';
import './custom-drawer.dart';
import './create-model-page.dart';
import './list-model-page.dart';
import './model-detail-page.dart';

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
      onGenerateRoute: (settings) {
        if (settings.name == '/model-detail') {
          final args = settings.arguments as Map<String, String>;
          return MaterialPageRoute(
            builder: (context) {
              return MainScreen(
                title: args['title']!,
                isHome: false,
                backRoute: '/list',
                child: ModelDetailPage(
                  title: args['title']!,
                ),
              );
            },
          );
        }
        return null;
      },
      routes: <String, WidgetBuilder>{
        '/': (context) =>
            const MainScreen(title: 'ホーム', child: MyHomePage(), isHome: true),
        '/creator': (context) => const MainScreen(
            title: '作成者用',
            child: ModelCreatorPage(),
            isHome: false,
            backRoute: '/'), //isHome: 戻るボタンの有無, backRoute: 戻るボタンの遷移先
        '/qr': (context) => const MainScreen(
            title: 'QR読み取り',
            child: QrReaderPage(),
            isHome: false,
            backRoute: '/'),
        '/list': (context) => const MainScreen(
            title: '保存したモデル一覧',
            child: ListModelPage(),
            isHome: false,
            backRoute: '/creator'),
        '/create-model': (context) => const MainScreen(
            title: 'モデル作成画面',
            child: CreateModelPage(),
            isHome: false,
            backRoute: '/creator')
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
    this.backRoute,
  });

  final String title;
  final Widget child;
  final bool isHome;
  final String? backRoute;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: Header(title: title, isHome: isHome, backRoute: backRoute),
      drawer: const CustomDrawer(),
      body: child,
    );
  }
}
