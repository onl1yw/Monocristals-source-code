import 'dart:math';
import 'package:flutter/material.dart';
import 'package:monocristals/settings/settings_box.dart';
import 'package:monocristals/slider_and_textfield.dart';
import 'package:monocristals/vault.dart';

import '../cristalls/function.dart';
import '../ratio_slider.dart';

class POECristalSettings extends StatelessWidget {
  const POECristalSettings({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SettingsBox(
          title: "Плоскость роста 100",
          children: [
            SliderAndTextField(
                dataName: "Угл между плоскостями",
                vaultKey: (value) => POEVault.angle.value = (value / 180) * pi,
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
                dataName: "Скорость роста влево / вправо 100",
                vaultKey: (value) => POEVault.velL_velR_10.value = value),
            SliderAndTextField(
                dataName: "Коэфицент b 100",
                vaultKey: (value) => POEVault.b_10.value = value,
                initialValue: 2.5,
                min: 0,
                max: 10),
            SliderAndTextField(
                dataName: "Коэфицент i 100",
                vaultKey: (value) => POEVault.i_10.value = value,
                initialValue: 0.5,
                min: 0,
                max: 1),
            SliderAndTextField(
                dataName: "Коэфицент d_110 100",
                vaultKey: (value) => POEVault.d_110_10.value = value,
                initialValue: 0.5,
                min: 0,
                max: 1),
            SliderAndTextField(
                dataName: "Коэфицент l_0 100",
                vaultKey: (value) => POEVault.l_0_10.value = value,
                initialValue: 5,
                min: 0,
                max: 10),
            SliderAndTextField(
                dataName: "Угл fi 100",
                initialValue: 100,
                vaultKey: (value) => POEVault.fi_10.value = (value / 180) * pi,
                min: -360,
                max: 360),
          ],
        ),
        SizedBox.fromSize(size: const Size(0, 20)),
        SettingsBox(
          title: 'Плоскость роста 120',
          children: [
            SliderAndTextField(
                dataName: "Коэфицент b 120",
                vaultKey: (value) => POEVault.b_12.value = value,
                initialValue: 2.5,
                min: 0,
                max: 10),
            SliderAndTextField(
                dataName: "Коэфицент i 120",
                vaultKey: (value) => POEVault.i_12.value = value,
                initialValue: 0.5,
                min: 0,
                max: 1),
            SliderAndTextField(
                dataName: "Коэфицент d_110 120",
                vaultKey: (value) => POEVault.d_110_12.value = value,
                initialValue: 0.5,
                min: 0,
                max: 1),
            SliderAndTextField(
                dataName: "Коэфицент l_0 120",
                vaultKey: (value) => POEVault.l_0_12.value = value,
                initialValue: 5,
                min: 0,
                max: 10),
            SliderAndTextField(
                dataName: "Угл fi 120",
                initialValue: 100,
                vaultKey: (value) => POEVault.fi_12.value = (value / 180) * pi,
                min: -360,
                max: 360),
          ],
        ),
      ],
    );
  }
}
