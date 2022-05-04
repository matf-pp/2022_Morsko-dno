import 'package:flutter/material.dart';

class MyKraba extends StatelessWidget {
  final x;
  MyKraba({this.x});
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      alignment: Alignment(x, 1.15),
      duration: Duration(milliseconds: 0),
      child: Image.asset(
        'lib/slike/crab.gif',
        height:150,
        width:150,
      ),
    );
  }
}