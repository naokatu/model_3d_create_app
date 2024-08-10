import 'package:flutter/material.dart';
import 'dart:typed_data';

class ThumbnailWidget extends StatelessWidget {
  final List<Uint8List> thumbnails;

  const ThumbnailWidget({super.key, required this.thumbnails});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 20,
      bottom: 20,
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.white, width: 2),
              borderRadius: BorderRadius.circular(8),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: Image.memory(
                thumbnails[0],
                width: 80,
                height: 80,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ],
      ),
    );
  }
}