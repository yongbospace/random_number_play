import 'package:flutter/material.dart';

class NumberMap extends StatelessWidget {
  final int number;
  const NumberMap({
    required this.number,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: number
          .toString()
          .split('')
          .map((y) => Image.asset(
                'assets/images/$y.png',
                width: 50,
                height: 70,
              ))
          .toList(),
    );
  }
}
