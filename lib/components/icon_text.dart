import 'package:flutter/material.dart';

class IconText extends StatelessWidget {
  const IconText({super.key, required this.icon, required this.text});

  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          icon,
          size: MediaQuery.textScalerOf(context).scale(14),
          color: Theme.of(context).colorScheme.outline,
        ),
        Flexible(
          flex: 1,
          child: Text(
            text,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: Theme.of(context).colorScheme.outline,
                ),
          ),
        ),
      ],
    );
  }
}
