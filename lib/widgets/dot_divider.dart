import 'package:flutter/material.dart';

class DotDivider extends StatelessWidget {
  final double radius;

  const DotDivider({
    super.key,
    this.radius = 1,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: radius * 2,
      width: radius * 2,
      decoration: BoxDecoration(
        color: Colors.grey[600],
        borderRadius: BorderRadius.circular(100),
      ),
    );
  }
}
