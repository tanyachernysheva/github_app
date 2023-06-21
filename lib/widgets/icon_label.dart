import 'package:flutter/material.dart';

class IconLabel extends StatelessWidget {
  final Widget leading;
  final String label;

  const IconLabel({
    super.key,
    required this.leading,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        leading,
        const SizedBox(
          width: 4,
        ),
        Text(label),
      ],
    );
  }
}
