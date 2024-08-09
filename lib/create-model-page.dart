import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'dart:typed_data';
import './input-dialog.dart';
import './capture-button.dart';
import './instruction-widget.dart';
import './thumbnail-widget.dart';
import './instruction-complete-widget.dart';
import './create-model-button.dart';
import './dimension-input-dialog.dart';
import 'package:flutter/services.dart';

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
  bool _isLoading = false;
  final List<String> _instructions = [
    '料理の真上から撮影してください',
    '料理の真横（正面）から撮影してください',
    '料理の真横（右側面）から撮影してください',
    '料理の真横（左側面）から撮影してください',
    '料理の裏側から撮影してください',
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
    // 5回押されていたら撮影ボタンを無効化
    if (_photoCount >= 5) return;

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
      builder: (context) => const InputDialog(
        title: '3Dモデル作成',
        hintText: '料理の名前を入力してください',
      ),
    );

    if (filename.isNotEmpty) {
     final dimensions = await showDialog(
       context: context,
       builder: (context) => const DimensionInputDialog(title: '寸法を入力してください'),
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

  Future<void> _createModelAndNavigate(String filename, Map<String, double> dimensions) async {
    await _createModel(filename, dimensions);
    // 処理が終了したら
    if (mounted) {
      Navigator.of(context)
          .pushNamed('/model-detail', arguments: {'filename': filename});
    }
  }

  // TODO:モデルの作成処理
  Future<void> _createModel(String filename, Map<String, double> dimensions) async {
    const platform = MethodChannel('com.example.app/model');
  
    try {
      final result = await platform.invokeMethod('create3DModel', {
        'width': dimensions['width'],
        'height': dimensions['height'],
        'length': dimensions['length'],
        'filename': filename,
      });

      if (result == 'Model created successfully') {
      print('3Dモデルの作成が完了しました');
      } else {
      throw Exception('Unexpected result: $result');
      }
    } on PlatformException catch (e) {
      print("Failed to create 3D model: ${e.message}");
      // モデル作成が失敗した場合、画面遷移しないようにする
      return;
    } catch (e) {
      print("Error: ${e.toString()}");
      return;
    }
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
          // 5枚撮っていない場合は指示を出す
          if (_photoCount < 5)
            InstructionWidget(instruction: _instructions[_photoCount]),
          // 画面左下に撮影した写真のサムネイル表示
          if (_thumbnails.isNotEmpty) ThumbnailWidget(thumbnails: _thumbnails),
          // 5枚撮り終わったらメッセージとボタンの活性化
          if (_photoCount >= 5)
            const InstructionCompleteWidget(),
          CreateModelButton(
            photoCount: _photoCount,
            onPressed: _showInputDialog,
          ),
            if (_isLoading)  // ローディング中はインジケーターを表示
            Container(
              color: Colors.black54,
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            ),
        ],
      ),
    );
  }
}