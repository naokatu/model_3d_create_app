import 'package:flutter/material.dart';

class SelectButton extends StatelessWidget {
  const SelectButton({
    super.key,
    required this.buttonText,
    required this.iconPath,
    required this.nextPage,
  });

  final String buttonText;
  final String? iconPath;
  final String nextPage;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8),
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: OutlinedButton(
          onPressed: () {
            Navigator.of(context).pushNamed(nextPage,arguments: {'filename': buttonText},);
          },
          style: OutlinedButton.styleFrom(
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // 画像がある場合画像と余白を描画
              if (iconPath != null)
                Container(
                    margin: const EdgeInsets.only(right: 30),
                    child: Image.asset(
                      iconPath!,
                      width: 64,
                      height: 64,
                    )),
              Text(buttonText,
                  style: const TextStyle(
                      color: Color(0xFF1A237E),
                      fontWeight: FontWeight.bold,
                      fontSize: 20)),
            ],
          )),
    );
  }
}
