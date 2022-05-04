import 'package:flutter/material.dart';

class MyTrava extends StatelessWidget {
  final x;
  final y;

  MyTrava({this.x,this.y});
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 0),
      alignment: Alignment(x,y),
      child: Image.asset(
        'lib/slike/grass.png',
        height:80,
      ),
    );
  }
}