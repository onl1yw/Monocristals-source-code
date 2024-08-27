import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RatioSlider extends StatefulWidget {
  final double min1;
  final double max1;
  final double min2;
  final double max2;
  final String dataName;
  final void Function(double quotient) vaultKey;
  final double initialValue1; // Add this line
  final double initialValue2; // Add this line

  const RatioSlider({
    Key? key,
    required this.min1,
    required this.max1,
    required this.min2,
    required this.max2,
    required this.dataName,
    required this.vaultKey,
    required this.initialValue1, // Add this line
    required this.initialValue2, // Add this line
  }) : super(key: key);

  @override
  _RatioSliderState createState() => _RatioSliderState();
}

class _RatioSliderState extends State<RatioSlider> {
  late TextEditingController _controller1;
  late double _sliderValue1;
  late TextEditingController _controller2;
  late double _sliderValue2;

  @override
  void initState() {
    super.initState();
    _controller1 = TextEditingController();
    _sliderValue1 = widget.initialValue1; // Use the initial value from the widget
    _controller1.text = _sliderValue1.toStringAsFixed(2);

    _controller2 = TextEditingController();
    _sliderValue2 = widget.initialValue2; // Use the initial value from the widget
    _controller2.text = _sliderValue2.toStringAsFixed(2);

    _updateQuotient();
  }

  @override
  void dispose() {
    _controller1.dispose();
    _controller2.dispose();
    super.dispose();
  }

  void _updateQuotient() {
    double quotient = _sliderValue1 / _sliderValue2;
    widget.vaultKey(quotient);
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
          child: Column(
            children: [
              Row(
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
                            overlayShape:
                                RoundSliderOverlayShape(overlayRadius: 0),
                          ),
                          child: Slider(
                            value: _sliderValue1,
                            min: widget.min1,
                            max: widget.max1,
                            activeColor: Colors.grey[700],
                            inactiveColor: Colors.grey[500],
                            onChanged: (double value) {
                              setState(() {
                                _sliderValue1 = value;
                                _controller1.text = value.toStringAsFixed(2);
                                //widget.vaultKey(value);
                                _updateQuotient();
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
                          controller: _controller1,
                          onSubmitted: (String value) {
                            value = value.replaceAll(',', '.');
                            double? newValue = double.tryParse(value);
                            if (newValue != null) {
                              setState(() {
                                if (newValue! < widget.min1) {
                                  newValue = widget.min1;
                                } else if (newValue! > widget.max1) {
                                  newValue = widget.max1;
                                }
                                _sliderValue1 = newValue!;
                                // widget.vaultKey(newValue!);
                                _updateQuotient();
                                _controller1.text =
                                    _sliderValue1.toStringAsFixed(2);
                              });
                            } else {
                              _controller1.text =
                                  _sliderValue1.toStringAsFixed(2);
                            }
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const Divider(
                color: Colors.grey,
                height: 10, // Adjust this to change the space between the divider and the surrounding widgets
                thickness: 2, // Adjust this to change the thickness of the divider
                indent: 20, // Adjust this to change the left-side length of the divider
                endIndent: 20, // Adjust this to change the right-side length of the divider
              ),
              Row(
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
                            overlayShape:
                            RoundSliderOverlayShape(overlayRadius: 0),
                          ),
                          child: Slider(
                            value: _sliderValue2,
                            min: widget.min2,
                            max: widget.max2,
                            activeColor: Colors.grey[700],
                            inactiveColor: Colors.grey[500],
                            onChanged: (double value) {
                              setState(() {
                                _sliderValue2 = value;
                                _controller2.text = value.toStringAsFixed(2);
                                //widget.vaultKey(value);
                                _updateQuotient();
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
                          controller: _controller2,
                          onSubmitted: (String value) {
                            value = value.replaceAll(',', '.');
                            double? newValue = double.tryParse(value);
                            if (newValue != null) {
                              setState(() {
                                if (newValue! < widget.min2) {
                                  newValue = widget.min2;
                                } else if (newValue! > widget.max2) {
                                  newValue = widget.max2;
                                }
                                _sliderValue2 = newValue!;
                                //widget.vaultKey(newValue!);
                                _updateQuotient();
                                _controller2.text =
                                    _sliderValue2.toStringAsFixed(2);
                              });
                            } else {
                              _controller2.text =
                                  _sliderValue2.toStringAsFixed(2);
                            }
                          },
                        ),
                      ),
                    ),
                  ),
                ],
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
