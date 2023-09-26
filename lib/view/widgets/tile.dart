import 'package:flutter/material.dart';

class Tile extends StatelessWidget {
  final Widget child;
  final double _defaultMaxWidth = 1200;
  double? maxWidth;
  Tile({super.key, required this.child, this.maxWidth});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 7,
            offset: const Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      width: _calculateWidth(context),
      padding: const EdgeInsets.all(20),
      child: child,
    );
  }

  double _calculateWidth(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double? maxWidth = this.maxWidth ?? _defaultMaxWidth;
    if (width > maxWidth) {
      width = maxWidth;
    }
    return width;
  }
}
