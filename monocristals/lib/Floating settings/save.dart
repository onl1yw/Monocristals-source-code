// image.dart
import 'dart:convert';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:monocristals/vault.dart';
import 'package:flutter/services.dart';
import 'dart:html' as html;

class SaveFloatingButton extends StatelessWidget {
  SaveFloatingButton();

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        // Convert the Vault values to a JSON string
        String json = jsonEncode({
          // 'd_110': Vault.d_110.value,
          // 'i': Vault.i.value,
          // 'l_0': Vault.l_0.value,
          // 'fi': Vault.fi.value,
          // 'velL_velR': Vault.velL_velR.value,
          // 'b': Vault.b.value,
          // 'angle': Vault.angle.value,
          // 'imRotate': Vault.imRotate.value,
          // 'imScale': Vault.imScale.value,
          // 'imX': Vault.imX.value,
          // 'imY': Vault.imY.value,
          // 'scale': Vault.scale.value,
        });

        // Create a Blob from the JSON string
        final blob = html.Blob([json]);

        // Create a URL for the Blob
        final url = html.Url.createObjectUrlFromBlob(blob);

        // Create a link with the URL and a download attribute
        final anchor = html.AnchorElement(href: url)
          ..setAttribute('download', 'vault_values.json')
          ..click();

        // Revoke the URL
        html.Url.revokeObjectUrl(url);
      },
      child: Icon(Icons.save, color: Colors.grey[800]),
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
