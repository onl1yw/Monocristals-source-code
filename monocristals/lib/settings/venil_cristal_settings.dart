import 'dart:math';
import 'package:flutter/material.dart';
import 'package:monocristals/slider_and_textfield.dart';
import 'package:monocristals/vault.dart';

import '../cristalls/function.dart';
import '../ratio_slider.dart';

class VenilCristalSettings extends StatelessWidget {
  const VenilCristalSettings({super.key});

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
      ),
    );
  }
}