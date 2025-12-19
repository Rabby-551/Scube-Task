import 'dart:math' as math;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ArcGaugeIndicator extends StatelessWidget {
  const ArcGaugeIndicator({
    super.key,
    required this.size,
    required this.value,
    this.trackColor = const Color(0xFFE5EDF6),
    this.startAngle = 3 * math.pi / 4,
    this.sweepAngle = 3 * math.pi / 2,
    this.gradientColors,
    this.strokeWidthFactor = 0.16,
  });

  final double size;
  final double value;
  final Color trackColor;
  final double startAngle;
  final double sweepAngle;
  final List<Color>? gradientColors;
  final double strokeWidthFactor;

  @override
  Widget build(BuildContext context) {
    final strokeWidth = size * strokeWidthFactor;

    return SizedBox(
      width: size,
      height: size,
      child: CustomPaint(
        painter: _ArcGaugePainter(
          value: value,
          trackColor: trackColor,
          gradientColors: gradientColors ??
              const [
                Color(0xFF4B83FF),
                Color(0xFF52C5FF),
              ],
          startAngle: startAngle,
          sweepAngle: sweepAngle,
          strokeWidth: strokeWidth,
        ),
      ),
    );
  }
}

class _ArcGaugePainter extends CustomPainter {
  const _ArcGaugePainter({
    required this.value,
    required this.trackColor,
    required this.gradientColors,
    required this.startAngle,
    required this.sweepAngle,
    required this.strokeWidth,
  });

  final double value;
  final Color trackColor;
  final List<Color> gradientColors;
  final double startAngle;
  final double sweepAngle;
  final double strokeWidth;

  @override
  void paint(Canvas canvas, Size size) {
    final double clampedValue = value.clamp(0.0, 1.0).toDouble();
    final rect = Offset(strokeWidth / 2, strokeWidth / 2) &
        Size(size.width - strokeWidth, size.height - strokeWidth);

    final trackPaint = Paint()
      ..color = trackColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    canvas.drawArc(rect, startAngle, sweepAngle, false, trackPaint);

    final progressSweep = sweepAngle * clampedValue;
    if (progressSweep <= 0) return;

    final progressPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round
      ..shader = SweepGradient(
        startAngle: startAngle,
        endAngle: startAngle + progressSweep,
        colors: gradientColors,
      ).createShader(rect);

    canvas.drawArc(rect, startAngle, progressSweep, false, progressPaint);
  }

  @override
  bool shouldRepaint(covariant _ArcGaugePainter oldDelegate) {
    return oldDelegate.value != value ||
        oldDelegate.trackColor != trackColor ||
        oldDelegate.startAngle != startAngle ||
        oldDelegate.sweepAngle != sweepAngle ||
        oldDelegate.strokeWidth != strokeWidth ||
        !listEquals(oldDelegate.gradientColors, gradientColors);
  }
}
