import 'package:flutter/material.dart';

class MyPlastika extends StatelessWidget {

  final ind;
  final x;

  MyPlastika({this.ind,this.x});

  @override
  Widget build(BuildContext context) {
    if(ind==1) {//bag
      return AnimatedContainer(
        alignment: Alignment(x, -0.4),
        duration: Duration(milliseconds: 0),
        child: Image.asset(
          'lib/slike/bag.png',
          height: 80,
          width: 80,
        ),
      );
    } else if(ind==2){//bottle
      return AnimatedContainer(
        alignment: Alignment(x, 0.3),
        duration: Duration(milliseconds: 0),
        child: Image.asset(
          'lib/slike/bottle.png',
          height: 85,
          width: 85,
        ),
      );
    } else { //ind=3, cup
      return AnimatedContainer(
        alignment: Alignment(x, 0.5),
        duration: Duration(milliseconds: 0),
        child: Image.asset(
          'lib/slike/cup.png',
          height: 50,
          width: 50,
        ),
      );
    }
  }
}