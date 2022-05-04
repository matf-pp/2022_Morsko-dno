import 'package:flutter/material.dart';

class MyRiba extends StatelessWidget {
  final indr;

  MyRiba({this.indr});
  @override
  Widget build(BuildContext context) {
    if (indr==1) {
      return Container(
        child: Image.asset(
          'lib/slike/riba.png',
          height: 80,
          width: 80,
        ),
      );
    }else if(indr==2) {
      return Container(
        child: Image.asset(
          'lib/slike/riba2.png',
          height: 90,
          width: 90,
        ),
      );
    }else if(indr==3){
      return Container(
        //alignment: Alignment.center,
        child: Image.asset(
          'lib/slike/riba3.png',
          height:80,
          width:80,
        ),
      );
    } else{
      return Container(
        child: Image.asset(
          'lib/slike/riba4.png',
          height: 100,
          width: 100,
        ),
      );
    }
  }
}
