import 'dart:math';
import 'package:flutter/material.dart';
import 'package:random_number_play/components/number_map.dart';
import 'package:random_number_play/constants/colors.dart';
import 'package:random_number_play/screens/setting_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int maxNumber = 1000;

  List<int> randomNumbers = [
    123,
    456,
    789,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _Header(onPressed: onSettingPressed),
              _Main(randomNumbers: randomNumbers),
              _Footer(onPressed: onGeneratePressed)
            ],
          ),
        ),
      ),
    );
  }

  void onGeneratePressed() {
    final Set<int> newNumbers = {};

    while (newNumbers.length != 3) {
      int number = Random().nextInt(maxNumber);
      newNumbers.add(number);
    }
    setState(() {
      randomNumbers = newNumbers.toList();
    });
  }

  void onSettingPressed() async {
    final int? result = await Navigator.of(context).push<int>(
      MaterialPageRoute(
        builder: (BuildContext context) {
          return SettingScreen(
            maxNumber: maxNumber,
          );
        },
      ),
    );

    if (result != null) {
      setState(() {
        maxNumber = result;
      });
    }
    ;
  }
}

class _Header extends StatelessWidget {
  final VoidCallback onPressed;

  const _Header({
    required this.onPressed,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          'Random Number Play',
          style: TextStyle(
            color: textColor,
            fontSize: 24,
            fontWeight: FontWeight.w600,
          ),
        ),
        IconButton(
          onPressed: onPressed,
          icon: const Icon(Icons.settings),
          color: textColor,
        ),
      ],
    );
  }
}

class _Main extends StatelessWidget {
  final List<int> randomNumbers;
  const _Main({required this.randomNumbers, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: randomNumbers
            .asMap()
            .entries
            .map((x) => Padding(
                padding: EdgeInsets.only(bottom: x.key == 2 ? 0 : 8),
                child: NumberMap(
                  number: x.value,
                )))
            .toList(),
      ),
    );
  }
}

class _Footer extends StatelessWidget {
  final VoidCallback onPressed;

  const _Footer({
    required this.onPressed,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          primary: btnColor,
          padding: const EdgeInsets.all(12),
        ),
        child: const Text(
          'Generate',
          style: TextStyle(
            color: textColor,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
