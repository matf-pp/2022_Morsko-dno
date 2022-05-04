import 'package:flutter/material.dart';

class MyPrepreka extends StatelessWidget {

  final ind;
  final size;
  final y;
  final x;

  MyPrepreka({this.ind,this.size,this.x,this.y});

  @override
  Widget build(BuildContext context) {
    if(ind==1) {   //gore
      return AnimatedContainer(
        alignment: Alignment(x,y),
        duration: Duration(milliseconds: 0),
        child: Image.asset(
          'lib/slike/eel_down.gif',
          width: size,
          height: size,
        ),
      );
    } else { // ind=2 dole
      return AnimatedContainer(
        alignment: Alignment(x,y),
        duration: Duration(milliseconds: 0),
        child: Image.asset(
          'lib/slike/seaweed2.gif',
          width: size,
          height: size,
        ),
      );
    }
  }
}
