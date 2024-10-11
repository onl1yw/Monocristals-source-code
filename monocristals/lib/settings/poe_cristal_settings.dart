import 'dart:math';
import 'package:flutter/material.dart';
import 'package:monocristals/settings/settings_box.dart';
import 'package:monocristals/slider_and_textfield.dart';
import 'package:monocristals/vault.dart';

import '../cristalls/function.dart';
import '../ratio_slider.dart';
import 'dropdown_chip.dart';

class POECristalSettings extends StatelessWidget {
  const POECristalSettings({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // DropdownChip(
        //   values: ['Normal Mode', 'Advanced Mode'],
        //   initialValue: 'Normal Mode',
        //   onSelected: (value) {
        //     POEVault.isAdvancedMode.value = (value == 'Advanced Mode');
        //     if (value == 'Normal Mode') {
        //       POEVault.defaultValues();
        //     }
        //   },
        // ),
        ValueListenableBuilder<bool>(
          valueListenable: POEVault.isAdvancedMode,
          builder: (context, isAdvancedMode, child) {
            return Column(
              children: [
                SettingsBox(
                  title: "Плоскость роста 120",
                  children: [
                      // SliderAndTextField(
                      //     dataName: "Угл между плоскостями",
                      //     vaultKey: (value) => POEVault.angle.value = (value / 180) * pi,
                      //     initialValue: POEVault.angle.value,
                      //     min: 0,
                      //     max: 180),
                    SliderAndTextField(
                        dataName: "Масштаб кристалла",
                        vaultKey: (value) {
                          Vault.scale.value = value;
                          Cristal.scale = value;
                        },
                        initialValue: Vault.scale.value,
                        min: 1,
                        max: 500),
                    RatioSlider(
                        min1: 0,
                        max1: 10,
                        min2: 0,
                        max2: 10,
                        initialValue1: POEVault.velL_velR_10.value,
                        initialValue2: 1,
                        dataName: "Скорость роста влево / вправо 120",
                        vaultKey: (value) => POEVault.velL_velR_10.value = value),
                    // SliderAndTextField(
                    //     dataName: "Коэфицент b 120",
                    //     vaultKey: (value) => POEVault.b_10.value = value,
                    //     initialValue: POEVault.b_10.value,
                    //     min: 0,
                    //     max: 10),
                    SliderAndTextField(
                        dataName: "Коэфицент i 120",
                        vaultKey: (value) => POEVault.i_10.value = value,
                        initialValue: POEVault.i_10.value,
                        min: 0,
                        max: 1),
                    SliderAndTextField(
                        dataName: "Коэфицент d_110 120",
                        vaultKey: (value) => POEVault.d_110_10.value = value,
                        initialValue: POEVault.d_110_10.value,
                        min: 0,
                        max: 1),
                    if (isAdvancedMode)
                      SliderAndTextField(
                          dataName: "Коэфицент l_0 120",
                          vaultKey: (value) => POEVault.l_0_10.value = value,
                          initialValue: POEVault.l_0_10.value,
                          min: 0,
                          max: 10),
                    if (isAdvancedMode)
                      SliderAndTextField(
                          dataName: "Угл fi 120",
                          initialValue: POEVault.fi_10.value,
                          vaultKey: (value) => POEVault.fi_10.value = (value / 180) * pi,
                          min: -360,
                          max: 360),
                  ],
                ),
                SizedBox.fromSize(size: const Size(0, 20)),
                SettingsBox(
                  title: 'Плоскость роста 100',
                  children: [
                    // SliderAndTextField(
                    //     dataName: "Коэфицент b 100",
                    //     vaultKey: (value) => POEVault.b_12.value = value,
                    //     initialValue: POEVault.b_12.value,
                    //     min: 0,
                    //     max: 10),
                    SliderAndTextField(
                        dataName: "Коэфицент √i 100",
                        vaultKey: (value) => POEVault.i_12.value = value * value,
                        initialValue: sqrt(POEVault.i_12.value),
                        min: 0,
                        max: 0.02),
                    // SliderAndTextField(
                    //     dataName: "Коэфицент d_110 100",
                    //     vaultKey: (value) => POEVault.d_110_12.value = value,
                    //     initialValue: POEVault.d_110_12.value,
                    //     min: 0,
                    //     max: 1),
                    if (isAdvancedMode)
                      SliderAndTextField(
                          dataName: "Коэфицент l_0 100",
                          vaultKey: (value) => POEVault.l_0_12.value = value,
                          initialValue: POEVault.l_0_12.value,
                          min: 0,
                          max: 10),
                  ],
                ),
              ],
            );
          },
        ),
      ],
    );
  }
}