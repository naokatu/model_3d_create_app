import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QrCreatePage extends StatelessWidget {
  final String url;

  const QrCreatePage({super.key, required this.url});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Container(
          color: Colors.white,
          child: QrImageView(
            data: url,
            version: QrVersions.auto,
            size: 250.0,
          ),
      )
    );
  }
}
