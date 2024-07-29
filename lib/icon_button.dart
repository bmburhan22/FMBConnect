import 'package:flutter/material.dart';
import 'package:fmb_connect/main.dart';

class TextIconButton extends StatelessWidget {
  final void Function()? onTap;
  final Color? color, textColor;
  final String text;
  final IconData? icon;
  final double borderRadius;
    const TextIconButton(
      {this.onTap, this.color=Colors.teal, required this.text, this.textColor=Colors.white, this.icon, this.borderRadius=10, super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onTap,
        child: Container(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
            decoration: BoxDecoration(
                color: color, borderRadius: BorderRadius.circular(borderRadius)),
            child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (icon != null) Icon(icon, color: Colors.white),
                  Text(
                    text,
                    style: Theme.of(context)
                        .textTheme
                        .titleSmall!
                        .copyWith(color: Colors.white),
                  ),
                ].divide(const SizedBox(width: 10)))));
  }
}
