import 'package:flutter/material.dart';
import 'package:tmdb/screens/widgets/rate/starts.dart';

class Rate extends StatelessWidget {
  final double rate;
  Rate(this.rate);

  @override
  Widget build(BuildContext context) => Stack(
        children: [
          Stars(Colors.white),
          ClipRect(
            child: Stars(Colors.yellow),
            clipper: _RateClipper(rate),
          ),
        ],
      );
}

class _RateClipper extends CustomClipper<Rect> {
  final double rate;
  _RateClipper(this.rate);

  @override
  Rect getClip(Size size) =>
      Rect.fromLTWH(0, 0, size.width * rate, size.height);

  @override
  bool shouldReclip(CustomClipper<Rect> oldClipper) => false;
}
