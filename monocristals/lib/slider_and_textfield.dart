import 'dart:math';
import 'package:flutter/material.dart';
import 'package:monocristals/vault.dart';

class SliderAndTextField extends StatefulWidget {
  final double min;
  final double max;
  final String dataName;
  final void Function(double valuable) vaultKey;
  final double initialValue; // Add this line

  const SliderAndTextField({
    Key? key,
    required this.dataName,
    required this.vaultKey,
    required this.min,
    required this.max,
    required this.initialValue, // Add this line
  }) : super(key: key);

  @override
  State<SliderAndTextField> createState() => _SliderAndTextFieldState();
}

class _SliderAndTextFieldState extends State<SliderAndTextField> {
  late TextEditingController _controller;
  late double _sliderValue;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    _sliderValue = widget.initialValue; // Use the initial value from the widget
    _controller.text = _sliderValue.toStringAsFixed(2);

    widget.vaultKey(widget
        .initialValue); // Set the initial text of the TextEditingController
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          margin: const EdgeInsets.only(top: 20),
          padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 3),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade300, width: 2),
            boxShadow: [
              BoxShadow(
                color: Colors.grey[300]!,
                blurRadius: 1.0,
                spreadRadius: 0.0,
                offset: const Offset(0, 0),
              )
            ],
            color: Colors.white,
            borderRadius: BorderRadius.circular(7),
          ),
          child: Row(
            children: [
              Expanded(
                flex: 3,
                child: Padding(
                  padding: const EdgeInsets.only(left: 12.0),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: SliderTheme(
                      data: SliderThemeData(
                        thumbColor: Colors.grey[700],
                        thumbShape:
                            RoundSliderThumbShape(enabledThumbRadius: 10),
                        overlayShape: RoundSliderOverlayShape(overlayRadius: 0),
                      ),
                      child: Slider(
                        value: _sliderValue,
                        min: widget.min,
                        max: widget.max,
                        activeColor: Colors.grey[700],
                        inactiveColor: Colors.grey[500],
                        onChanged: (double value) {
                          setState(() {
                            _sliderValue = value;
                            _controller.text = value.toStringAsFixed(2);
                            widget.vaultKey(value);
                          });
                        },
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Container(
                  width: 175,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 10.0),
                    child: TextField(
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: '0.00',
                      ),
                      textAlign: TextAlign.center,
                      controller: _controller,
                      onSubmitted: (String value) {
                        value = value.replaceAll(',', '.');
                        double? newValue = double.tryParse(value);
                        if (newValue != null) {
                          setState(() {
                            if (newValue! < widget.min) {
                              newValue = widget.min;
                            } else if (newValue! > widget.max) {
                              newValue = widget.max;
                            }
                            _sliderValue = newValue!;
                            widget.vaultKey(newValue!);
                            _controller.text = _sliderValue.toStringAsFixed(2);
                          });
                        } else {
                          _controller.text = _sliderValue.toStringAsFixed(2);
                        }
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Positioned(
          top: 5,
          left: 10,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(
                color: Colors.grey.shade300,
                width: 1,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey[300]!,
                  blurRadius: 1.0,
                  spreadRadius: 0.0,
                  offset: const Offset(0, 0),
                ),
              ],
              borderRadius: BorderRadius.circular(10), // Add this line
            ),
            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 0),
            child: Text(
              widget.dataName,
              style: const TextStyle(color: Colors.black),
            ),
          ),
        ),
      ],
    );
  }
}
