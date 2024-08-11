import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'dart:typed_data';
import 'dart:io';
import './filename-input-dialog.dart';
import './dimension-input-dialog.dart';
import './capture-button.dart';
import './instruction-widget.dart';
import './thumbnail-widget.dart';
import './instruction-complete-widget.dart';
import './create-model-button.dart';
import './api_service.dart';

class CreateModelPage extends StatefulWidget {
  const CreateModelPage({super.key});

  @override
  State<CreateModelPage> createState() => _CreateModelPage();
}

class _CreateModelPage extends State<CreateModelPage> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;
  List<Uint8List> _thumbnails = [];
  int _photoCount = 0;
  late bool _isLoading = false;
  final List<String> _instructions = [
    'カメラの横幅（縦幅）に料理をあわせて真上から撮影してください',
  ];

  // カメラ初期化
  @override
  void initState() {
    super.initState();
    _initializeControllerFuture = _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    final cameras = await availableCameras();
    final firstCamera = cameras.first;
    _controller = CameraController(firstCamera, ResolutionPreset.medium);
    return _controller.initialize();
  }

  // カメラの動作内容
  @override
  // ウィジェットが破棄されたらコントローラーも破棄
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  // 撮影ボタン
  void _onCaptureButtonPressed() async {
    // 撮影されていたら撮影ボタンを無効化
    if (_photoCount >= 1) return;

    try {
      await _initializeControllerFuture;
      final image = await _controller.takePicture();
      final bytes = await image.readAsBytes();
      setState(() {
        _thumbnails.insert(0, bytes);
        _photoCount++;
      });
    } catch (e) {
      print(e);
    }
  }

  // 3Dモデル作成ボタンが押された時のダイアログボックス
  void _showInputDialog() async {
    final filename = await showDialog(
      context: context,
      builder: (context) => const FilenameInputDialog(
        title: '3Dモデル作成',
        hintText: '料理の名前を入力してください',
      ),
    );

    // 入力されたファイル名が空ではない時
    if (filename.isNotEmpty && mounted) {
      final dimensions = await showDialog(
        context: context,
        builder: (context) =>
            const DimensionInputDialog(title: '料理の大きさを入力してください'),
      );

      if (dimensions != null && mounted) {
        setState(() {
          _isLoading = true;  // ローディング開始
        });
        await _createModelAndNavigate(filename, dimensions);
        setState(() {
          _isLoading = false;  // ローディング終了
        });
      }
    }
  }

  // モデルの作成と画面遷移
  Future<void> _createModelAndNavigate(String filename, Map<String, double> dimensions) async {
    final modelUrl = await _getModel(filename, dimensions);
    await _saveModel(modelUrl);

    final title = Uri.decodeComponent(modelUrl.split('/').last.split('.').first);

    // 処理が終了したら
    if (mounted) {
      Navigator.of(context)
          .pushNamed('/model-detail', arguments: {'title': title, 'url': modelUrl});
    }
  }

  // httpリクエストでURLを取得
  Future<String> _getModel(String filename, Map<String, double> dimensions) async {
    final modelUrl = await ApiService.createModel(filename: filename, dimensions: dimensions);

    return modelUrl;
  }

  // テキストファイルにURLを書き込む
  Future<void> _saveModel(String modelUrl) async {
    final directory = await getApplicationDocumentsDirectory();
    final urlPath = '${directory.path}/url/models.txt';
    final file = File(urlPath);

    if(!await file.exists()) {
      await file.create(recursive: true);
    }

    await file.writeAsString('$modelUrl\n', mode: FileMode.append);
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      // カメラのプレビュー
      child: Stack(
        children: [
          Column(
            children: [
              Expanded(
                child: FutureBuilder<void>(
                  future: _initializeControllerFuture,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      return CameraPreview(_controller);
                    } else {
                      return const Center(child: CircularProgressIndicator());
                    }
                  },
                ),
              ),
              CaptureButton(
                onPressed: _onCaptureButtonPressed,
              ),
            ],
          ),
          // 撮っていない場合は指示を出す
          if (_photoCount < 1)
            InstructionWidget(instruction: _instructions[_photoCount]),
          // 画面左下に撮影した写真のサムネイル表示
          if (_thumbnails.isNotEmpty) ThumbnailWidget(thumbnails: _thumbnails),
          // 撮り終わったらメッセージとボタンの活性化
          if (_photoCount >= 1) const InstructionCompleteWidget(),
          CreateModelButton(
            photoCount: _photoCount,
            onPressed: _showInputDialog,
          ),
          if (_isLoading)  // ローディング中はインジケーターを表示
            Container(
              color: Colors.black54,
              child: const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '3Dモデルを作成しています。\nしばらくお待ちください',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 20),
                    CircularProgressIndicator()
                  ],
                )
              )
            ),
        ],
      ),
    );
  }
}
