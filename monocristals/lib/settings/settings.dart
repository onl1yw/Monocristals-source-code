import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:monocristals/settings/pe_cristal_settings.dart';
import 'package:monocristals/settings/poe_cristal_settings.dart';
import 'package:monocristals/settings/image_settings.dart';
import 'package:monocristals/settings/test_cristal_settings.dart';
import 'package:monocristals/settings/venil_cristal_settings.dart';
import 'package:monocristals/vault.dart';

import 'dropdown_chip.dart';

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
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: const Color(0xFFF5F5F5),
                border: Border.all(
                  color: Colors.grey.shade700,
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              padding: const EdgeInsets.all(10.0),
              child: Container(
                padding:
                    const EdgeInsets.only(left: 0, right: 0, top: 5, bottom: 5),
                child: Wrap(
                  runSpacing: 10,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  alignment: WrapAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Настройки кристалла',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                        fontWeight: FontWeight.w300,
                      ),
                      textAlign: TextAlign.left,
                      softWrap: true,
                    ),
                    const SizedBox(width: 7, height: 7),
                    DropdownChip(
                      values: ['PE', 'POE', 'poly-(2-vynilpyridine)'/*, 'Test'*/],
                      initialValue: 'PE',
                      onSelected: (value) {
                        CristalType selectedType;
                        switch (value) {
                          case 'PE':
                            selectedType = CristalType.PE;
                            break;
                          case 'POE':
                            selectedType = CristalType.POE;
                            break;
                          case 'poly-(2-vynilpyridine)':
                            selectedType = CristalType.VENIL;
                            break;
                          // case 'Test':
                          //   selectedType = CristalType.TEST;
                          //   break;
                          default:
                            selectedType = CristalType.PE;
                        }
                        Vault.cristalType.value = selectedType;
                      },
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
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
                  case CristalType.TEST:
                    return const TestCristalSettings();
                  default:
                    return const SizedBox.shrink();
                }
              },
            ),
            const SizedBox(
                height: 20), // Add some space between the two sections
            ValueListenableBuilder<ui.Image?>(
              valueListenable: Vault.bgImage,
              builder: (context, bgImage, child) {
                if (bgImage == null) {
                  return const SizedBox
                      .shrink(); // Return an empty widget if no image
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
