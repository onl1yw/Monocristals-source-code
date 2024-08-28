import 'dart:math';
import 'package:flutter/material.dart';
import 'package:monocristals/slider_and_textfield.dart';
import 'package:monocristals/vault.dart';

class ImageSettings extends StatelessWidget {
  const ImageSettings({super.key});

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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: EdgeInsets.only(left: 5, right: 0, top: 10, bottom: 10),
                child: const Align(
                  alignment: Alignment.centerLeft,
                  child: Text("Настройки изображения",
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                          fontWeight: FontWeight.w300),
                      textAlign: TextAlign.left),
                ),
              ),
              IconButton(
                icon: Icon(Icons.close, color: Colors.grey),
                onPressed: () {
                  Vault.bgImage.value = null; // Delete the image from the Vault
                },
              ),
            ],
          ),
          SliderAndTextField(
              dataName: "Смещение по горизонтали",
              vaultKey: (value) => Vault.imX.value = value,
              initialValue: 0,
              min: -100,
              max: 100),
          SliderAndTextField(
              dataName: "Смещение по вертикали",
              vaultKey: (value) => Vault.imY.value = value,
              initialValue: 0,
              min: -100,
              max: 100),
          SliderAndTextField(
              dataName: "Угл поворота изображения",
              vaultKey: (value) => Vault.imRotate.value = (value / 180) * pi,
              initialValue: 90,
              min: -360,
              max: 360),
          SliderAndTextField(
              dataName: "Масштаб изображения",
              vaultKey: (value) => Vault.imScale.value = value,
              initialValue: 1,
              min: 0,
              max: 2),
        ],
      ),
    );
  }
}