import 'package:flutter/material.dart';
import 'package:random_number_play/components/number_map.dart';
import 'package:random_number_play/constants/colors.dart';

class SettingScreen extends StatefulWidget {
  final int maxNumber;

  const SettingScreen({
    required this.maxNumber,
    Key? key,
  }) : super(key: key);

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  double maxNumber = 1000;

  @override
  void initState() {
    // TODO: implement initState
    maxNumber = widget.maxNumber.toDouble();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        child: SafeArea(
          child: Column(
            children: [
              _Main(maxNumber: maxNumber),
              _Footer(
                onSliderChange: onSliderChange,
                maxNumber: maxNumber,
                onButtonPressed: onButtonPressed,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void onSliderChange(double val) {
    setState(() {
      maxNumber = val;
    });
  }

  void onButtonPressed() {
    Navigator.of(context).pop(maxNumber.toInt());
  }
}

class _Main extends StatelessWidget {
  final double maxNumber;

  const _Main({
    required this.maxNumber,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(child: NumberMap(number: maxNumber.toInt()));
  }
}

class _Footer extends StatelessWidget {
  final ValueChanged<double> onSliderChange;
  final double maxNumber;
  final VoidCallback onButtonPressed;

  const _Footer({
    required this.onSliderChange,
    required this.maxNumber,
    required this.onButtonPressed,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Slider(
          value: maxNumber,
          min: 1000,
          max: 100000,
          onChanged: onSliderChange,
        ),
        ElevatedButton(
          onPressed: onButtonPressed,
          style: ElevatedButton.styleFrom(
            primary: btnColor,
            padding: const EdgeInsets.all(12),
          ),
          child: const Text(
            'Confirm',
            style: TextStyle(
              color: textColor,
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}
