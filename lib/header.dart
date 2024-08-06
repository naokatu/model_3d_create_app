import 'package:flutter/material.dart';

class Header extends StatelessWidget implements PreferredSizeWidget {
  const Header({super.key, required this.title, this.isHome = false, this.backRoute});

  final String title;
  final bool isHome;
  final String? backRoute;
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: const Color(0xFF1A237E),
      title: Text(
        title,
        style: const TextStyle(color: Colors.white),
      ),
      iconTheme: const IconThemeData(color: Colors.white),
      actions: isHome
          ? null
          : [
              IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  if (backRoute != null) {
                    Navigator.pushNamedAndRemoveUntil(context, backRoute!, (Route<dynamic> route) => false);
                  } else {
                    Navigator.pop(context);
                  }
                },
              ),
            ],
    );
  }
  
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}