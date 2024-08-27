import 'dart:math';
import 'package:flutter/material.dart';
import 'package:monocristals/slider_and_textfield.dart';
import 'package:monocristals/vault.dart';

import '../function.dart';
import '../ratio_slider.dart';

class CristalSettings extends StatelessWidget {
  const CristalSettings({super.key});

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
            child: const Align(
              alignment: Alignment.centerLeft,
              child: Text("Настройки параметров роста",
                  style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                      fontWeight: FontWeight.w300),
                  textAlign: TextAlign.left),
            ),
          ),
          SliderAndTextField(
              dataName: "Угл между плоскостями",
              vaultKey: (value) => Vault.angle.value = (value / 180) * pi,
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
              vaultKey: (value) => Vault.velL_velR.value = value),
          SliderAndTextField(
              dataName: "Коэфицент b",
              vaultKey: (value) => Vault.b.value = value,
              initialValue: 2.5,
              min: 0,
              max: 10),
          SliderAndTextField(
              dataName: "Коэфицент i",
              vaultKey: (value) => Vault.i.value = value,
              initialValue: 0.5,
              min: 0,
              max: 1),
          SliderAndTextField(
              dataName: "Коэфицент d_110",
              vaultKey: (value) => Vault.d_110.value = value,
              initialValue: 0.5,
              min: 0,
              max: 1),
          SliderAndTextField(
              dataName: "Коэфицент l_0",
              vaultKey: (value) => Vault.l_0.value = value,
              initialValue: 5,
              min: 0,
              max: 10),
          SliderAndTextField(
              dataName: "Угл fi",
              initialValue: 100,
              vaultKey: (value) => Vault.fi.value = (value / 180) * pi,
              min: -360,
              max: 360),
        ],
      ),
    );
  }
}