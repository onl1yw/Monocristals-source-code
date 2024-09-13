import 'package:flutter/material.dart';

class SettingsBox extends StatelessWidget {
  final List<Widget> children;
  final String title;
  final double fontSize;

  const SettingsBox({
    super.key,
    required this.children,
    required this.title,
    this.fontSize = 16,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFF5F5F5),
        border: Border.all(
          color: Colors.grey.shade700,
          width: 2,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.only(left: 5, right: 0, top: 10, bottom: 10),
            child: Text(
              title,
              style: TextStyle(
                fontSize: fontSize,
                color: Colors.black,
                fontWeight: FontWeight.w300,
              ),
              textAlign: TextAlign.left,
              softWrap: true,
            ),
          ),
          ...children,
        ],
      ),
    );
  }
}
