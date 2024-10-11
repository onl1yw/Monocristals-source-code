import 'dart:ui' as ui;
import 'package:flutter/material.dart';

class MemoFloatingButton extends StatefulWidget {
  @override
  _MemoFloatingButtonState createState() => _MemoFloatingButtonState();
}

class _MemoFloatingButtonState extends State<MemoFloatingButton> {
  void _showMemoDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: Stack(
            children: [
              Image.asset('assets/Table.png'),
              Positioned(
                right: 0,
                top: 0,
                child: IconButton(
                  icon: Icon(Icons.close),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () => _showMemoDialog(context),
      child: Image.asset('assets/Bookmark Computer Icons.png', color: Colors.grey[800], height: 24),
      backgroundColor: Color(0xFFF5F5F5),
      splashColor: Colors.grey,
      shape: CircleBorder(
        side: BorderSide(
          color: Colors.grey[800]!,
          width: 2,
        ),
      ),
    );
  }
}