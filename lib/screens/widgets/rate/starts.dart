import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

class Stars extends StatelessWidget {
  final Color color;
  final int count;
  Stars(this.color, {this.count = 5});
  @override
  Widget build(BuildContext context) => Row(
        mainAxisSize: MainAxisSize.min,
        children: List.generate(
          count,
          (_) => Icon(PlatformIcons(context).star, color: color),
        ),
      );
}
