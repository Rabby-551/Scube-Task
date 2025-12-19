import 'package:flutter/material.dart';

class DonutProgressIndicator extends StatelessWidget {
  const DonutProgressIndicator({
    super.key,
    required this.size,
    this.value = 0.9,
    this.backgroundColor = const Color(0xFFE0E8EE),
    this.valueColor = const Color(0xFF2B89C7),
  });

  final double size;
  final double value;
  final Color backgroundColor;
  final Color valueColor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: CircularProgressIndicator(
        value: value,
        strokeWidth: size * 0.10,
        strokeCap: StrokeCap.round,
        backgroundColor: backgroundColor,
        valueColor: AlwaysStoppedAnimation<Color>(valueColor),
      ),
    );
  }
}
