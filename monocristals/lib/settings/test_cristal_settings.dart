import 'dart:math';
import 'package:flutter/material.dart';
import 'package:monocristals/settings/settings_box.dart';
import 'package:monocristals/slider_and_textfield.dart';
import 'package:monocristals/vault.dart';

import '../cristalls/function.dart';
import '../ratio_slider.dart';

class TestCristalSettings extends StatelessWidget {
  const TestCristalSettings({super.key});

  @override
  Widget build(BuildContext context) {
    return SettingsBox(
      title: "Test Crystal Settings",
      children: [
        SliderAndTextField(
            dataName: "Angle between planes",
            vaultKey: (value) => TestVault.angle.value = (value / 180) * pi,
            initialValue: 60,
            min: 0,
            max: 180),
        SliderAndTextField(
            dataName: "Crystal scale",
            vaultKey: (value) {
              Vault.scale.value = value;
              Cristal.scale = value; // Update the scale value in the OvalLine class
            },
            initialValue: 200,
            min: 1,
            max: 500),
        RatioSlider(
            min1: 0,
            max1: 10,
            min2: 0,
            max2: 10,
            initialValue1: 1,
            initialValue2: 1,
            dataName: "Growth speed left / right",
            vaultKey: (value) => TestVault.velL_velR.value = value),
        SliderAndTextField(
            dataName: "Coefficient b",
            vaultKey: (value) => TestVault.b.value = value,
            initialValue: 2.5,
            min: 0,
            max: 10),
        SliderAndTextField(
            dataName: "Coefficient i",
            vaultKey: (value) => TestVault.i.value = value,
            initialValue: 0.5,
            min: 0,
            max: 1),
        SliderAndTextField(
            dataName: "Coefficient d_110",
            vaultKey: (value) => TestVault.d_110.value = value,
            initialValue: 0.5,
            min: 0,
            max: 1),
        SliderAndTextField(
            dataName: "Coefficient l_0",
            vaultKey: (value) => TestVault.l_0.value = value,
            initialValue: 5,
            min: 0,
            max: 10),
        SliderAndTextField(
            dataName: "Angle fi",
            initialValue: 100,
            vaultKey: (value) => TestVault.fi.value = (value / 180) * pi,
            min: -360,
            max: 360),
      ],
    );
  }
}