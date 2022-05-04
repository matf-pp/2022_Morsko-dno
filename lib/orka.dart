import 'package:flutter/material.dart';

class MyOrka extends StatelessWidget {
  final x;
  MyOrka({this.x});
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      alignment: Alignment(x, 0),
      duration: Duration(milliseconds: 0),
      child: Image.asset(
        'lib/slike/orka.png',
        height:300,
        width:300,
      ),
    );
  }
}