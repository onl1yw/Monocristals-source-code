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
          '\n'
          'PE cristal': {
            'd_110': PEVault.d_110.value,
            'i': PEVault.i.value,
            'velL/velR': PEVault.velL_velR.value,
          },
          '\n'
          'POE cristal': {
            'Main fronts:': {
              'd_110': POEVault.d_110_12.value,
              'i': POEVault.i_12.value,
              'velL/velR': POEVault.velL_velR_12.value,
            },
            'Support fronts:': {
              'd_110': POEVault.d_110_10.value,
              'i': POEVault.i_10.value,
            },
          },
          '\n'
          'Venil cristal': {
            'd_110': VenilVault.d_110.value,
            'i': VenilVault.i.value,
            'l_0': VenilVault.l_0.value,
            'velL/velR': VenilVault.velL_velR.value,
            'b': VenilVault.b.value,
          },
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
