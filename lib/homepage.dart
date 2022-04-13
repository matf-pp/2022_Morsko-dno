import 'dart:async';

import 'riba.dart';
import 'eel.dart';
import 'package:flutter/material.dart';

import 'prepreke.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static double ribaY = 0;
  double vreme = 0;
  double visina = 0;
  double pocetnaVisina = ribaY;
  bool gameHasStarted = false;
  double prepreka1_x = 1.8;
  double prepreka2_x = 1.8 + 1.5;
  double prepreka3_x = 1.8 + 3;
  bool pocetakIgre = false; //gameStarted
  int rezultat = 0;
  int najboljiRezultat = 0;
  double eelX=2.5;

  static double preprekaSirina=0.2;
  List<List<double>> preprekaVisina=[
    [0.4,0.9],
    [0.8,0.7],
    [0.5,0.9],
  ];

  @override
  void initState() {
    setState(() {
      ribaY = 0;
      vreme = 0;
      visina = 0;
      pocetnaVisina = ribaY;
      prepreka1_x = 1.8;
      prepreka2_x = 1.8 + 1.5;
      prepreka3_x = 1.8 + 3;
      pocetakIgre = false;
      rezultat = 0;
      eelX=4;

      preprekaSirina=0.2;
      preprekaVisina=[
        [0.4,0.9],
        [0.8,0.7],
        [0.5,0.9],
      ];
    });
  }

  void jump() {
    setState(() {
      vreme = 0;
      pocetnaVisina = ribaY;
    });
  }

  bool checkLose() { //umire kad udari u prepreku
    if (prepreka1_x < 0.17 && prepreka1_x > -0.17) {
      if (ribaY < -0.7 || ribaY > 0.2) {
        return true;
      }
    }
    if (prepreka2_x < 0.17 && prepreka2_x > -0.17) {
      if (ribaY < -0.3 || ribaY > 0.4) {
        return true;
      }
    }
    if (prepreka3_x < 0.17 && prepreka3_x > -0.17) {
      if (ribaY < -0.6 || ribaY > 0.2) {
        return true;
      }
    }
    if(eelX<0.14 && eelX>-0.17 && ribaY>-0.18 && ribaY<0.2) {
      return true;
    }
    return false;
  }

  void startGame() {
    gameHasStarted = true;
    Timer.periodic(Duration(milliseconds: 60), (timer) {
      vreme += 0.05;
      visina = -3 * vreme * vreme + 2 * vreme;
      setState(() {
        ribaY = pocetnaVisina - visina;
        if (prepreka1_x < -1.3) {  //pocetno 1.8
          prepreka1_x += 4.5;
          rezultat++;
        } else { //prepreka1_x >= -1
          prepreka1_x -= 0.04; //kretanje
        }
        if(eelX<-1.3){
          eelX+=8;
        } else {
          eelX -= 0.06;
        }
        if (prepreka2_x < -1.3) {  //pocetno 3.3
          prepreka2_x += 4.5;
          rezultat++;
        } else {
          prepreka2_x -= 0.04;
        }
        if (prepreka3_x < -1.3) {   //pocetno 4.8
          prepreka3_x += 4.5;
          rezultat++;
        } else {
          prepreka3_x -= 0.04;
        }


      });
      if (ribaY<-1 || ribaY>1 || checkLose()) {
        timer.cancel();
        _showDialog();
      }
    });
  }

  void _showDialog() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Colors.brown,
            title: Text(
              "KRAJ IGRE",
              style: TextStyle(color: Colors.white),
            ),
            content: Text(
              "rezultat: " + rezultat.toString(),
              style: TextStyle(color: Colors.white),
            ),
            actions: [
              FlatButton(
                child: Text(
                  "IGRAJ PONOVO",
                  style: TextStyle(color: Colors.white, backgroundColor: Colors.brown[700]),
                ),
                onPressed: () {
                  if (rezultat > najboljiRezultat) {
                    najboljiRezultat = rezultat;
                  }
                  initState();
                  setState(() {
                    gameHasStarted = false;
                  });
                  Navigator.of(context).pop();

                },
              )
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (gameHasStarted) {
          jump();
        } else {
          startGame();
        }
      },
      child: Scaffold(
        body: Column(
          children: [
            Expanded(
                flex: 4,
                child: Stack(
                  children: [
                    AnimatedContainer(
                      alignment: Alignment(0, ribaY),
                      duration: Duration(milliseconds: 0),
                      color: Colors.teal[300],
                      child: MyRiba(),
                    ),
                    Container(
                      alignment: Alignment(0, -0.3),
                      child: gameHasStarted
                          ? Text(" ")
                          : Text("Z A P O Č N I   I G R U",
                          style:
                          TextStyle(fontSize: 30, color: Colors.white)),
                    ),
                    AnimatedContainer(
                      alignment: Alignment(eelX, 0),
                      duration: Duration(milliseconds: 0),
                      child: MyEel(
                      ),
                    ),
                    AnimatedContainer(
                      alignment: Alignment(prepreka1_x, -1.1),
                      duration: Duration(milliseconds: 0),
                      child: MyPrepreka(
                        preprekaSirina: preprekaSirina,
                        preprekaVisina: preprekaVisina[0][0],
                      ),
                    ),
                    //Bottom barrier 0
                    AnimatedContainer(
                      alignment: Alignment(prepreka1_x, 1.1),
                      duration: Duration(milliseconds: 0),
                      child: MyPrepreka(
                        preprekaSirina: preprekaSirina,
                        preprekaVisina: preprekaVisina[0][1],
                      ),
                    ),
                    //Top barrier 1
                    AnimatedContainer(
                      alignment: Alignment(prepreka2_x, -1.1),
                      duration: Duration(milliseconds: 0),
                      child: MyPrepreka(
                        preprekaSirina: preprekaSirina,
                        preprekaVisina: preprekaVisina[1][0],
                      ),
                    ),
                    //Bottom barrier 1
                    AnimatedContainer(
                      alignment: Alignment(prepreka2_x, 1.1),
                      duration: Duration(milliseconds: 0),
                      child: MyPrepreka(
                        preprekaSirina: preprekaSirina,
                        preprekaVisina: preprekaVisina[1][1],
                      ),
                    ),
                    AnimatedContainer(
                      alignment: Alignment(prepreka3_x, -1.1),
                      duration: Duration(milliseconds: 0),
                      child: MyPrepreka(
                        preprekaSirina: preprekaSirina,
                        preprekaVisina: preprekaVisina[2][0],
                      ),
                    ),
                    //Bottom barrier 1
                    AnimatedContainer(
                      alignment: Alignment(prepreka3_x, 1.1),
                      duration: Duration(milliseconds: 0),
                      child: MyPrepreka(
                        preprekaSirina: preprekaSirina,
                        preprekaVisina: preprekaVisina[2][1],
                      ),
                    ),
                   

                  ],
                )),
           
            Expanded(
              child: Container(
                color: Colors.orange[200],
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("REZULTAT",
                            style:
                            TextStyle(color: Colors.brown, fontSize: 20)),
                        SizedBox(
                          height: 20,
                        ),
                        Text(rezultat.toString(),
                            style:
                            TextStyle(color: Colors.brown, fontSize: 35)),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("NAJBOLJI REZULTAT",
                            style:
                            TextStyle(color: Colors.brown, fontSize: 20)),
                        SizedBox(
                          height: 20,
                        ),
                        Text(najboljiRezultat.toString(),
                            style:
                            TextStyle(color: Colors.brown, fontSize: 35)),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}