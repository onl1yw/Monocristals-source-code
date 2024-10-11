import 'dart:math';

import 'package:flutter/material.dart';
import 'package:monocristals/Canvas/monocristal_canvas.dart';
import 'package:monocristals/cristalls/pe_cristal.dart';
import 'package:monocristals/settings/settings.dart';
import 'package:monocristals/vault.dart';
import 'package:monocristals/cristalls/function.dart';
import 'dart:ui' as ui;

import 'cristalls/poe_cristal.dart';
import 'cristalls/test_cristal.dart';
import 'cristalls/venil_cristal.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Monocristalls',
      theme: ThemeData(
        useMaterial3: false,
      ),
      home: const MyHomePage(title: 'Monocristalls'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Cristal> cristal = [];
  ui.Image? bgImage;

  @override
  void initState() {
    super.initState();
    _setupListeners();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _updateCanvas();
    });
  }

  void _setupListeners() {
    Vault.cristalType.addListener(_updateCanvas);
    Vault.bgImage.addListener(_updateCanvas);
    Vault.scale.addListener(_updateCanvas);

    // Add listeners for PEcristal
    PEVault.d_110.addListener(_updateCanvas);
    PEVault.i.addListener(_updateCanvas);
    PEVault.l_0.addListener(_updateCanvas);
    PEVault.fi.addListener(_updateCanvas);
    PEVault.velL_velR.addListener(_updateCanvas);
    PEVault.b.addListener(_updateCanvas);
    PEVault.angle
        .addListener(_updateCanvas); // Added angle listener for PEcristal

    // Add listeners for POEcristal
    POEVault.d_110_10.addListener(_updateCanvas);
    POEVault.i_10.addListener(_updateCanvas);
    POEVault.l_0_10.addListener(_updateCanvas);
    POEVault.fi_10.addListener(_updateCanvas);
    POEVault.velL_velR_10.addListener(_updateCanvas);
    POEVault.b_10.addListener(_updateCanvas);
    POEVault.angle
        .addListener(_updateCanvas); // Added angle listener for POEcristal

    POEVault.d_110_12.addListener(_updateCanvas);
    POEVault.i_12.addListener(_updateCanvas);
    POEVault.l_0_12.addListener(_updateCanvas);
    POEVault.fi_12.addListener(_updateCanvas);
    POEVault.velL_velR_12.addListener(_updateCanvas);
    POEVault.b_12.addListener(_updateCanvas);
    POEVault.angle
        .addListener(_updateCanvas); // Added angle listener for POEcristal

    // Add listeners for Venilcristal
    VenilVault.d_110.addListener(_updateCanvas);
    VenilVault.i.addListener(_updateCanvas);
    VenilVault.l_0.addListener(_updateCanvas);
    VenilVault.fi.addListener(_updateCanvas);
    VenilVault.velL_velR.addListener(_updateCanvas);
    VenilVault.b.addListener(_updateCanvas);
    VenilVault.angle
        .addListener(_updateCanvas); // Added angle listener for Venilcristal
  }

  void _updateCanvas() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        switch (Vault.cristalType.value) {
          case CristalType.PE:
            cristal = [
              PEcristal(
                PEVault.d_110.value,
                PEVault.i.value,
                PEVault.l_0.value,
                PEVault.fi.value,
                PEVault.velL_velR.value,
                PEVault.b.value,
                PEVault.angle.value,
              )
            ];
            break;
          case CristalType.POE:
            cristal = [
              POEcristal100(
                POEVault.d_110_10.value,
                POEVault.i_10.value,
                POEVault.l_0_10.value,
                POEVault.fi_10.value,
                POEVault.velL_velR_10.value,
                POEVault.b_10.value,
                POEVault.angle.value,
              ),
              POEcristal120(
                POEVault.d_110_12.value,
                POEVault.i_12.value,
                POEVault.l_0_12.value,
                POEVault.fi_12.value,
                POEVault.velL_velR_12.value,
                POEVault.b_12.value,
                pi / 2,
              ),
            ];
            break;
          case CristalType.VENIL:
            cristal = [
              Venilcristal(
                VenilVault.d_110.value,
                VenilVault.i.value,
                VenilVault.l_0.value,
                VenilVault.fi.value,
                VenilVault.velL_velR.value,
                VenilVault.b.value,
                VenilVault.angle.value,
              )
            ];
            break;
          case CristalType.TEST:
            cristal = [
              TestCristal(
                TestVault.d_110.value,
                TestVault.i.value,
                TestVault.l_0.value,
                TestVault.fi.value,
                TestVault.velL_velR.value,
                TestVault.b.value,
                TestVault.angle.value,
              )
            ];
            break;
        }
        bgImage = Vault.bgImage.value;
      });
    });
  }

  @override
  void dispose() {
    // Vault.d_110.removeListener(_updateCanvas);
    // Vault.i.removeListener(_updateCanvas);
    // Vault.l_0.removeListener(_updateCanvas);
    // Vault.fi.removeListener(_updateCanvas);
    // Vault.velL_velR.removeListener(_updateCanvas);
    // Vault.b.removeListener(_updateCanvas);
    // Vault.bgImage.removeListener(_updateCanvas);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Container(
              margin: EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.grey[700]!, width: 2),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: EdgeInsets.all(15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(flex: 1, child: MySettings()),
                    Expanded(
                        flex: 2,
                        child:
                            CustomCanvas(cristals: cristal, bgImage: bgImage)),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
