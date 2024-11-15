import 'package:flutter/material.dart';

class CustomFilledButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  final TextStyle? textStyle;
  final bool isExpanded;
  final double height;
  const CustomFilledButton({
    super.key,
    required this.onPressed,
    required this.text,
    this.textStyle,
    this.isExpanded = false,
    this.height = 55,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: isExpanded ? double.infinity : null,
      child: FilledButton(
        style: ButtonStyle(
          padding: WidgetStateProperty.all(
            const EdgeInsets.symmetric(
              vertical: 16,
              horizontal: 12,
            ),
          ),
          shape: WidgetStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
        onPressed: onPressed,
        child: Text(
          text,
          style:
              textStyle ?? const TextStyle(fontSize: 16, color: Colors.white),
        ),
      ),
    );
  }
}
