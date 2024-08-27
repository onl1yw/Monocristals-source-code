import 'package:flutter/material.dart';
import 'package:monocristals/Canvas/monocristal_canvas.dart';
import 'package:monocristals/cristalls/pe_cristal.dart';
import 'package:monocristals/settings/settings.dart';
import 'package:monocristals/vault.dart';
import 'package:monocristals/function.dart';
import 'dart:ui' as ui;

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
  OvalLine cristal = PEcristal(Vault.d_110.value, Vault.i.value,
      Vault.l_0.value, Vault.fi.value, Vault.velL_velR.value, Vault.b.value);
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
    Vault.d_110.addListener(_updateCanvas);
    Vault.i.addListener(_updateCanvas);
    Vault.l_0.addListener(_updateCanvas);
    Vault.fi.addListener(_updateCanvas);
    Vault.velL_velR.addListener(_updateCanvas);
    Vault.b.addListener(_updateCanvas);
    Vault.scale.addListener(_updateCanvas);
    Vault.bgImage.addListener(_updateCanvas);
  }

  void _updateCanvas() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        cristal.update(
            d110: Vault.d_110.value,
            iMul: Vault.i.value,
            l: Vault.l_0.value,
            fi: Vault.fi.value,
            velL_velR: Vault.velL_velR.value,
            b: Vault.b.value);
        bgImage = Vault.bgImage.value;
      });
    });
  }

  @override
  void dispose() {
    Vault.d_110.removeListener(_updateCanvas);
    Vault.i.removeListener(_updateCanvas);
    Vault.l_0.removeListener(_updateCanvas);
    Vault.fi.removeListener(_updateCanvas);
    Vault.velL_velR.removeListener(_updateCanvas);
    Vault.b.removeListener(_updateCanvas);
    Vault.bgImage.removeListener(_updateCanvas);
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
                        child: CustomCanvas(cristal: cristal, bgImage: bgImage)),
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
