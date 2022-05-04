import 'package:flutter/material.dart';

class MyNovcic extends StatelessWidget {
  final x;
  final y;
  MyNovcic({this.x,this.y});

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      alignment: Alignment(x, y),
      duration: Duration(milliseconds: 0),
      child: Image.asset(
        'lib/slike/coin.gif',
        height:150,
        width:150,
      ),
    );
  }
}