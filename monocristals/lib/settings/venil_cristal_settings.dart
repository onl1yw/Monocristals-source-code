import 'dart:math';
import 'package:flutter/material.dart';
import 'package:monocristals/settings/settings_box.dart';
import 'package:monocristals/slider_and_textfield.dart';
import 'package:monocristals/vault.dart';

import '../cristalls/function.dart';
import '../ratio_slider.dart';

class VenilCristalSettings extends StatelessWidget {
  const VenilCristalSettings({super.key});

  @override
  Widget build(BuildContext context) {
    return SettingsBox(
        title: 'Поли 2 венил передин',
        children: [
          SliderAndTextField(
              dataName: "Масштаб кристалла",
              vaultKey: (value) {
                Vault.scale.value = value;
                OvalLine.scale =
                    value; // Update the scale value in the OvalLine class
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
              dataName: "Скорость роста влево / вправо",
              vaultKey: (value) => VenilVault.velL_velR.value = value),
          SliderAndTextField(
              dataName: "Коэфицент b",
              vaultKey: (value) => VenilVault.b.value = value,
              initialValue: 2.5,
              min: 0,
              max: 10),
          SliderAndTextField(
              dataName: "Коэфицент i",
              vaultKey: (value) => VenilVault.i.value = value,
              initialValue: 0.5,
              min: 0,
              max: 1),
          SliderAndTextField(
              dataName: "Коэфицент d_110",
              vaultKey: (value) => VenilVault.d_110.value = value,
              initialValue: 0.5,
              min: 0,
              max: 1),
          SliderAndTextField(
              dataName: "Коэфицент l_0",
              vaultKey: (value) => VenilVault.l_0.value = value,
              initialValue: 5,
              min: 0,
              max: 10),
          SliderAndTextField(
              dataName: "Угл fi",
              initialValue: 100,
              vaultKey: (value) => VenilVault.fi.value = (value / 180) * pi,
              min: -360,
              max: 360),
        ],
    );
  }
}