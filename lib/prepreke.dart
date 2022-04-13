import 'package:flutter/material.dart';

class MyPrepreka extends StatelessWidget {

  final preprekaSirina;
  final preprekaVisina;

  MyPrepreka(
  {
    this.preprekaVisina,
    this.preprekaSirina});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width * preprekaSirina/2,
        height: MediaQuery.of(context).size.height * 3/4 * preprekaVisina/2,
      decoration: BoxDecoration(
          color: Colors.brown[400],
          border: Border.all(width: 1,color: Colors.brown),
          borderRadius: BorderRadius.circular(10)
      ),
    );
  }
}

