import 'package:flutter/material.dart';

class MyMehuric extends StatelessWidget {
  final x;
  final y;
  MyMehuric({this.x,this.y});

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      alignment: Alignment(x,y),
      duration: Duration(milliseconds: 0),
      child: Image.asset(
        'lib/slike/mehuric.png',
        height:20,
        width:20,
      ),
    );
  }
}