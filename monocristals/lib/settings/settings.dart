import 'package:flutter/material.dart';
import 'package:monocristals/settings/cristal_settings.dart';
import 'package:monocristals/settings/image_settings.dart';

import 'cristal_settings.dart';
import 'image_settings.dart';

class MySettings extends StatefulWidget {
  const MySettings({super.key});

  @override
  State<MySettings> createState() => MySettingsState();
}

class MySettingsState extends State<MySettings> {
  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(0.0), // Add your desired padding here
      child: SingleChildScrollView(
        padding: EdgeInsets.only(top: 0, left: 0, right: 10, bottom: 0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CristalSettings(),
            SizedBox(height: 20), // Add some space between the two sections
            ImageSettings(),
          ],
        ),
      ),
    );
  }
}
