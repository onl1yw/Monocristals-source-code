import 'dart:convert';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';

import 'package:monocristals/vault.dart';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/services.dart';
import 'package:mime/mime.dart';

import '../vault.dart';

class ImageFloatingButton extends StatelessWidget {
  ImageFloatingButton();

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () async {
        try {
          FilePickerResult? result = await FilePicker.platform.pickFiles(
            type: FileType.custom,
            allowedExtensions: ['jpg', 'png', 'jpeg'],
          );

          if (result != null) {
            final Uint8List bytes = result.files.single.bytes!;
            final ui.Codec codec = await ui.instantiateImageCodec(bytes);
            final ui.FrameInfo frameInfo = await codec.getNextFrame();
            Vault.bgImage.value = frameInfo.image;
          }
        } on PlatformException catch (e) {
          print("Unsupported operation" + e.toString());
        } catch (ex) {
          print(ex);
        }
      },
      child: Icon(Icons.image, color: Colors.grey[800]),
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
