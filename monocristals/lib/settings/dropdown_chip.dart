import 'package:flutter/material.dart';

class DropdownChip extends StatefulWidget {
  final List<String> values;
  final String initialValue;
  final ValueChanged<String> onSelected;
  final double width;

  const DropdownChip({
    Key? key,
    required this.values,
    required this.initialValue,
    required this.onSelected,
    this.width = 150.0, // Default width
  }) : super(key: key);

  @override
  _DropdownChipState createState() => _DropdownChipState();
}

class _DropdownChipState extends State<DropdownChip> {
  late String _selectedValue;

  @override
  void initState() {
    super.initState();
    _selectedValue = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        hintColor: Colors.transparent,
        popupMenuTheme: const PopupMenuThemeData(
          color: Colors.white,
          elevation: 1,
        ),
        splashColor: Colors.grey[200], // <- Here
        highlightColor: Colors.transparent, // <- Here
        hoverColor: Colors.grey[200],
      ),
      child: PopupMenuButton<String>(
        onSelected: (value) {
          setState(() {
            _selectedValue = value;
          });
          widget.onSelected(value);
        },

        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
          side: const BorderSide(color: Colors.grey),
        ),

        itemBuilder: (context) {
          return widget.values.map((value) {
            return PopupMenuItem<String>(
              height: 30,
              value: value,
              child: Container(
                height: 25,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(100),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey[300]!,
                      blurRadius: 1.0,
                      spreadRadius: 1,
                    ),
                  ],
                ),
                child: ActionChip(
                  onPressed: () {
                    Navigator.pop(context, value);
                  },
                  disabledColor: Colors.white,
                  backgroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                      horizontal: -3.0, vertical: -2.0), // Adjust padding
                  labelStyle: const TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    height: 0.5,
                  ),
                  label: Text(value),
                  shape: const StadiumBorder(
                    side: BorderSide(color: Colors.grey),
                  ),
                ),
              ),
            );
          }).toList();
        },
        offset: Offset(0, 35),
        child: Container(
          height: 25,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.transparent),
            borderRadius: BorderRadius.circular(1000),
            boxShadow: [
              BoxShadow(
                color: Colors.grey[300]!,
                blurRadius: 1.0,
                spreadRadius: 0.0,
                offset: const Offset(0, 0),
              ),
            ],
          ),
          child: Theme(
            data: Theme.of(context).copyWith(
              chipTheme: const ChipThemeData(
                backgroundColor: Colors.white,
                shape: StadiumBorder(
                  side: BorderSide(color: Colors.grey),
                ),
              ),
            ),
            child: Chip(
              padding:
                  const EdgeInsets.symmetric(horizontal: -3.0, vertical: -2.0),
              label: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(_selectedValue,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        height: 0.4,
                      )),
                  Container(
                    padding: const EdgeInsets.only(bottom: 6),
                    child: Icon(Icons.arrow_drop_down),
                  ),
                ],
              ),
              backgroundColor: Colors.transparent,
              shape: const StadiumBorder(
                side: BorderSide(color: Colors.grey),
              ),
            ),
          ),
        ), // Align the left border
      ),
    );
  }
}
