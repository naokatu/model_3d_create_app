import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import './qr-reader-page.dart';
import './model-creator-page.dart';
import './header.dart';
import './my-home-page.dart';
import './custom-drawer.dart';
import './create-model-page.dart';
import './list-model-page.dart';
import './model-detail-page.dart';
import './qr-create-page.dart';

Future<void> main() async {
  await dotenv.load(fileName: '.env.local');
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
                title: args['title']!.split('/').last,
                isHome: false,
                backRoute: '/list',
                child: ModelDetailPage(
                  url: args['title']!,
                ),
              );
            },
          );
        }

        if (settings.name == '/qr-create-page') {
          final url = settings.arguments as String;
          return MaterialPageRoute(
            builder: (context) {
              return MainScreen(
                title: 'QRコード',
                isHome: false,
                child: QrCreatePage(url: url),
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
            isHome: false,
            backRoute: '/',
            child: ModelCreatorPage()), //isHome: 戻るボタンの有無, backRoute: 戻るボタンの遷移先
        '/qr': (context) => const MainScreen(
            title: 'QR読み取り',
            isHome: false,
            backRoute: '/',
            child: QrReaderPage()),
        '/list': (context) => const MainScreen(
            title: '保存したモデル一覧',
            isHome: false,
            backRoute: '/creator',
            child: ListModelPage()),
        '/create-model': (context) => const MainScreen(
            title: 'モデル作成画面',
            isHome: false,
            backRoute: '/creator',
            child: CreateModelPage()),
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
