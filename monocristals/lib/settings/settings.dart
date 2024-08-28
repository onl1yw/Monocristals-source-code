import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:monocristals/settings/pe_cristal_settings.dart';
import 'package:monocristals/settings/poe_cristal_settings.dart';
import 'package:monocristals/settings/image_settings.dart';
import 'package:monocristals/settings/venil_cristal_settings.dart';
import 'package:monocristals/vault.dart';

class MySettings extends StatefulWidget {
  const MySettings({super.key});

  @override
  State<MySettings> createState() => MySettingsState();
}

class MySettingsState extends State<MySettings> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(0.0), // Add your desired padding here
      child: SingleChildScrollView(
        padding: const EdgeInsets.only(top: 0, left: 0, right: 10, bottom: 0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ValueListenableBuilder<CristalType>(
              valueListenable: Vault.cristalType,
              builder: (context, cristalType, child) {
                switch (cristalType) {
                  case CristalType.PE:
                    return const PECristalSettings();
                  case CristalType.POE:
                    return const POECristalSettings();
                  case CristalType.VENIL:
                    return const VenilCristalSettings();
                  default:
                    return const SizedBox.shrink();
                }
              },
            ),
            const SizedBox(height: 20), // Add some space between the two sections
            ValueListenableBuilder<ui.Image?>(
              valueListenable: Vault.bgImage,
              builder: (context, bgImage, child) {
                if (bgImage == null) {
                  return const SizedBox.shrink(); // Return an empty widget if no image
                }
                return const ImageSettings();
              },
            ),
          ],
        ),
      ),
    );
  }
}
