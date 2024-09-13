import 'dart:math';
import 'package:flutter/material.dart';
import 'package:monocristals/settings/settings_box.dart';
import 'package:monocristals/slider_and_textfield.dart';
import 'package:monocristals/vault.dart';

import '../cristalls/function.dart';
import '../ratio_slider.dart';

class PECristalSettings extends StatelessWidget {
  const PECristalSettings({super.key});

  @override
  Widget build(BuildContext context) {
    return SettingsBox(
      title: "Плоскость роста 110",
      children: [
        SliderAndTextField(
            dataName: "Угл между плоскостями",
            vaultKey: (value) => PEVault.angle.value = (value / 180) * pi,
            initialValue: 60,
            min: 0,
            max: 180),
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
            vaultKey: (value) => PEVault.velL_velR.value = value),
        SliderAndTextField(
            dataName: "Коэфицент b",
            vaultKey: (value) => PEVault.b.value = value,
            initialValue: 2.5,
            min: 0,
            max: 10),
        SliderAndTextField(
            dataName: "Коэфицент i",
            vaultKey: (value) => PEVault.i.value = value,
            initialValue: 0.5,
            min: 0,
            max: 1),
        SliderAndTextField(
            dataName: "Коэфицент d_110",
            vaultKey: (value) => PEVault.d_110.value = value,
            initialValue: 0.5,
            min: 0,
            max: 1),
        SliderAndTextField(
            dataName: "Коэфицент l_0",
            vaultKey: (value) => PEVault.l_0.value = value,
            initialValue: 5,
            min: 0,
            max: 10),
        SliderAndTextField(
            dataName: "Угл fi",
            initialValue: 100,
            vaultKey: (value) => PEVault.fi.value = (value / 180) * pi,
            min: -360,
            max: 360),
      ],
    );
  }
}
