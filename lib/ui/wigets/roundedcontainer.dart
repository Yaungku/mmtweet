import 'package:flutter/material.dart';

class RoundedContainer extends StatelessWidget {
  final Widget child;
  final double height;
  final Color color;
  RoundedContainer({this.child, this.height, this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 20, right: 20),
      width: MediaQuery.of(context).size.width,
      height: height,
      decoration: BoxDecoration(
          border: Border.all(width: 1, color: Colors.grey),
          color: color,
          borderRadius: BorderRadius.all(Radius.circular(15))),
      child: child == null ? Container() : child,
    );
  }
}
