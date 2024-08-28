import 'dart:math';
import 'package:flutter/material.dart';
import 'package:monocristals/slider_and_textfield.dart';
import 'package:monocristals/vault.dart';

import '../cristalls/function.dart';
import '../ratio_slider.dart';

class POECristalSettings extends StatelessWidget {
  const POECristalSettings({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFF5F5F5),
        border: Border.all(
          color: Colors.grey.shade700,
          width: 2,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.only(left: 5, right: 0, top: 10, bottom: 10),
            child: const Text(
              "Настройки параметров роста",
              style: TextStyle(
                fontSize: 16,
                color: Colors.black,
                fontWeight: FontWeight.w300,
              ),
              textAlign: TextAlign.left,
              softWrap: true,
            ),
          ),
          DropdownMenu<CristalType>(
            menuStyle: MenuStyle(
              visualDensity: VisualDensity.compact,
            ),
            inputDecorationTheme: const InputDecorationTheme(
              isDense: true,
              border: InputBorder.none,
            ),
            initialSelection: Vault.cristalType.value,
            onSelected: (CristalType? newValue) {
              if (newValue != null) {
                Vault.cristalType.value = newValue;
              }
            },
            dropdownMenuEntries: CristalType.values.map((CristalType type) {
              return DropdownMenuEntry<CristalType>(
                value: type,
                label: getCristalTypeText(type),
              );
            }).toList(),
          ),
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
    );
  }
}

