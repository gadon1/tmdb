import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

class Rate extends StatelessWidget {
  final double rate;
  Rate(this.rate);

  int get normalizedRate => (rate / 2).round();

  @override
  Widget build(BuildContext context) => Stack(
        children: [
          Row(
            children: List.generate(
                normalizedRate,
                (index) => Icon(
                      PlatformIcons(context).star,
                      color: Colors.yellow,
                    ))
              ..addAll(List.generate(
                  5 - normalizedRate,
                  (index) => Icon(
                        PlatformIcons(context).star,
                        color: Colors.white,
                      ))),
          )
        ],
      );
}
