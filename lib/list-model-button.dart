import 'package:flutter/material.dart';

class ListModelButton extends StatelessWidget {
  const ListModelButton({
    super.key,
    required this.buttonText,
    required this.url
  });

  final String buttonText;
  final String url;

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
            Navigator.of(context).pushNamed('/model-detail',arguments: {'title': buttonText, 'url': url});
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
