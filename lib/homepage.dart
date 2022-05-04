import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'dart:async';
import 'riba.dart';
import 'plastika.dart';
import 'novcic.dart';
import 'orka.dart';
import 'kraba.dart';
import 'trava.dart';
import 'mehuric.dart';
import 'prepreke.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();

}

class _HomePageState extends State<HomePage> {


  static double ribaYaxis = 0;
  double vreme = 0;
  double visina = 0;
  double pocetnaVisina = ribaYaxis;
  bool gameHasStarted = false;
  List<double> prepreke = [];
  int rezultat = 0;
  int najboljiRezultat = 0;
  double novcic1 = 1.8 + 0.5;
  double novcic2 = 1.8 + 1.5 + 0.4;
  double novcic3 = 1.8 + 1.5 + 0.9;
  double kesa = 1.8 + 1.5 + 1.1;
  double flasa = 1.8 + 1.5 + 1.5 + 1.2;
  double casa = 1.8 + 1.5 + 0.5;
  double orka = 1.8 + 1.5 + 1.5 + 1.5 + 2;
  int indRibe=1;
  double kraba = 1.8 + 0.5;
  List<double> trava = [];
  List<double> mehuric = [];
  double ribe1=2.5;
  double ribe2=3.5;

  int ukupnoNovcica=0;
  int indNovcici=0;

  int ind=0;
  bool igraJeUToku=false;
  bool howToPlayProzor=false;



  @override
  void initState() {
    setState(() {

      ribaYaxis = 0;
      vreme = 0;
      visina = 0;
      pocetnaVisina = ribaYaxis;
      prepreke = [1.8,1.8+1.5,1.8+3,1.8+2.5];
      rezultat = 0;
      novcic1 = 1.8 + 0.5;
      novcic2 = 1.8 + 1.5 + 0.4;
      novcic3 = 1.8 + 1.5 + 0.7;
      indNovcici==0 ?
      kesa = 1.8 + 1.5 + 1
          : kesa = 100000;
      indNovcici<2 ?
      casa = 1.8 + 1.5 + 1.5 + 0.4
          : casa = 100000;
      indNovcici<3 ?
      flasa = 1.8 + 1.5 + 1.5 + 1.2
          : flasa = 100000;
      orka = 1.8 + 1.5 + 1.5 + 1.5 + 2;
      kraba = 1.8 + 0.1;
      trava = [-1,-0.2,0.6,1.4,2.2];
      mehuric = [1,1.5,2,2.5,3,3.5,4,4.8,5,5.5];
      ribe1 = 4.5;
      ribe2 = 6.5;

      igraJeUToku=false;

      ind=0;

    });

  }

  void jump() {
    setState(() {
      vreme = 0;
      pocetnaVisina = ribaYaxis;
    });
  }

  bool checkLose() { //umire kad udari u prepreku
    if (prepreke[0] < 0.08 && prepreke[0] > -0.08) {
      if (ribaYaxis < -0.3 || ribaYaxis > 0.45) {
        return true;
      }
    }
    if (prepreke[1] < 0.08 && prepreke[1] > -0.08) {
      if (ribaYaxis < -0.45 || ribaYaxis > 0.45) {
        return true;
      }
    }
    if (prepreke[2] < 0.08 && prepreke[2] > -0.08) {
      if (ribaYaxis < -0.55 || ribaYaxis > 0.45) {
        return true;
      }
    }
    if (prepreke[3] < 0.08 && prepreke[3] > -0.08) {
      if (ribaYaxis > 0.45) {
        return true;
      }
    }

    if(orka < 0.23 && orka > 0 && (ribaYaxis > -0.17 && ribaYaxis < 0.17)) {
      return true;
    }
    if(kraba < 0.15 && kraba > -0.15 && (ribaYaxis > 0.75)) {
      return true;
    }

    return false;
  }

  void startGame() {
    gameHasStarted = true;
    igraJeUToku=true;
    Timer.periodic(Duration(milliseconds: 60), (timer) {
      vreme += 0.04;
      visina = -4.9 * vreme * vreme + 2.8 * vreme;
      setState(() {
        ribaYaxis = pocetnaVisina - visina;
        for(int i=0;i<prepreke.length;i++){
          if(prepreke[i]<-0.3 && prepreke[i]>-0.33) {
            rezultat++;
          } if (prepreke[i] < -2) {
            prepreke[i] += 4.5;
          } else {
            prepreke[i] -= 0.04;
          }
        }

        // novcic1
        if (novcic1<-1.8) {
          novcic1 += 3;
        }else if(novcic1 < 0.08 && novcic1 > -0.08 && (ribaYaxis > -0.6 && ribaYaxis < -0.4)){
          novcic1+=3;
          rezultat+=3;
          ukupnoNovcica++;
        }
        novcic1 -= 0.04;
        // novcic2
        if (novcic2<-1.8) {
          novcic2 += 3;
        }else if(novcic2 < 0.08 && novcic2 > -0.08 && (ribaYaxis < 0.6 && ribaYaxis > 0.4)){
          novcic2+=3;
          rezultat+=3;
          ukupnoNovcica++;
        }
        novcic2 -= 0.04;
        // novcic3
        if (novcic3<-1.8) {
          novcic3 += 3;
        }else if(novcic3 < 0.08 && novcic3 > -0.08 && (ribaYaxis > -0.5 && ribaYaxis < -0.3)){
          novcic3+=3;
          rezultat+=2;
          ukupnoNovcica++;
        }
        novcic3 -= 0.04;

        //kesa
        if (ukupnoNovcica == 100 && indNovcici==0) {
          ind=0;
          kesa=100000;
          indNovcici=1;
          timer.cancel();
          showDialog(
              barrierDismissible: ind==0 ? false : true,
              context: context,
              builder: (context) {
                return AlertDialog(
                  backgroundColor: Colors.blue,
                  alignment: Alignment(0,0),
                  title: Text("BRAVO!",textAlign: TextAlign.center,style: TextStyle(color: Colors.white)),
                  content: Text(
                    "IZVAĐENE SU SVE KESE IZ MORA.",
                    style: TextStyle(color: Colors.white),
                  ),
                  actions: [
                    TextButton(
                      child: Text(
                          "NASTAVI IGRU",
                          style: TextStyle(color:Colors.white)),
                      onPressed: () {
                        ind=1;
                        setState(() {
                          gameHasStarted = false;
                        });
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                );
              });
        }
        else if(indNovcici==0) {
          if (kesa<-1.8) {
            kesa += 3;
          }else if(kesa < 0.1 && kesa > -0.1 && (ribaYaxis > -0.5 && ribaYaxis < -0.3)){
            kesa+=3;
            rezultat-=2;
          }
          kesa -= 0.04;
        }

        //casa
        if (ukupnoNovcica == 200 && indNovcici<2) {
          ind=0;
          casa=100000;
          indNovcici=2;
          timer.cancel();
          showDialog(
              barrierDismissible: ind==0 ? false : true,
              context: context,
              builder: (context) {
                return AlertDialog(
                  backgroundColor: Colors.blue,
                  alignment: Alignment(0, 0),
                  title: Text("BRAVO!",textAlign: TextAlign.center,style: TextStyle(color: Colors.white)),
                  content: Text(
                    "IZVAĐENE SU SVE ČAŠE IZ MORA",
                    style: TextStyle(color: Colors.white),
                  ),
                  actions: [
                    TextButton(
                      child: Text(
                          "NASTAVI IGRU",
                          style: TextStyle(color:Colors.white)),
                      onPressed: () {
                        ind=1;
                        setState(() {
                          gameHasStarted = false;
                        });
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                );
              });
        }
        else if(indNovcici<2) {
          if (casa<-1.8) {
            casa += 3;
          }else if(casa < 0.08 && casa > -0.08 && (ribaYaxis < 0.6 && ribaYaxis > 0.4)){
            casa+=3;
            rezultat-=2;
          }
          casa -= 0.04;
        }

        // flasa
        if (ukupnoNovcica == 300 && indNovcici<3) {
          ind=0;
          indNovcici=3;
          flasa=100000;
          timer.cancel();
          showDialog(
              barrierDismissible: ind==0 ? false : true,
              context: context,
              builder: (context) {
                return AlertDialog(
                  backgroundColor: Colors.blue,
                  alignment: Alignment(0, 0),
                  title: Text("MISIJA USPEŠNO OBAVLJENA!",textAlign: TextAlign.center,style: TextStyle(color: Colors.white)),
                  content:
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children:[
                      Text(
                        "Daca: Jeeeej! More je konačno čisto zahvaljujući tebi."
                            "\nVanja: Bravo!"
                            "\nBojko: Moram priznati da sam sumnjao hehe."
                            "\nMiki: Nadam se da ćemo se družiti ponovo!."
                            "\n\nHvala!\n",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white),
                      ),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children:[
                            AnimatedContainer(
                                alignment: Alignment(ribe1,-0.8),
                                duration: Duration(milliseconds: 0),
                                child:Image.asset(
                                  'lib/slike/gif1.gif',
                                  height:80,
                                )
                            ),
                            AnimatedContainer(
                                alignment: Alignment(ribe1,-0.8),
                                duration: Duration(milliseconds: 0),
                                child:Image.asset(
                                  'lib/slike/gif2.gif',
                                  height:80,
                                )
                            ),
                            AnimatedContainer(
                                alignment: Alignment(ribe1,-0.8),
                                duration: Duration(milliseconds: 0),
                                child:Image.asset(
                                  'lib/slike/gif3.gif',
                                  height:100,
                                )
                            ),
                            AnimatedContainer(
                                alignment: Alignment(ribe1,-0.8),
                                duration: Duration(milliseconds: 0),
                                child:Image.asset(
                                  'lib/slike/gif4.gif',
                                  height:90,
                                )
                            ),
                          ]
                      ),
                      Text(
                        "\nNaravno, ovo je samo mali korak, ako želiš da nastaviš misiju čišćenja okeana, klikni desno."
                            "\nAli najpre zaslužuješ pauzu! Klikni levo i uživaj u čistom moru."
                            "\nAko se kasnije odlučiš za nastavak misije, ribice će te spremno čekati!",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                  actions: [
                    TextButton(
                      child: Text(
                          "ZAVRŠI IGRU",
                          style: TextStyle(color:Colors.white),
                          textAlign: TextAlign.left),
                      onPressed: () {
                        ind=1;
                        if (rezultat > najboljiRezultat) {
                          najboljiRezultat = rezultat;
                        }
                        initState();
                        setState(() {
                          gameHasStarted = false;
                        });

                        Navigator.of(context).pop();
                      },
                    ),
                    TextButton(
                      child: Text(
                          "IGRAJ ISPOČETKA",
                          style: TextStyle(color:Colors.white),
                          textAlign: TextAlign.right),
                      onPressed: () {
                        ind=1;
                        if (rezultat > najboljiRezultat) {
                          najboljiRezultat = rezultat;
                        }
                        indNovcici=0;
                        ukupnoNovcica=0;
                        initState();
                        setState(() {
                          gameHasStarted = false;
                        });

                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                );
              });
        }
        else if(indNovcici<3) {
          if (flasa<-1.8) {
            flasa += 3;
          }else if(flasa < 0.08 && flasa > -0.08 && (ribaYaxis < 0.4 && ribaYaxis > 0.2)){
            flasa+=3;
            rezultat-=2;
          }
          flasa -= 0.04;
        }

        // orka
        if (orka<-1.8) {
          orka += 9;
        }
        orka -= 0.06;

        //kraba
        if(kraba<-1.8) {
          kraba += 3;
        }
        kraba -=0.025;

        for(int i=0;i<trava.length;i++){
          if(trava[i]<-1.8){
            trava[i]+=4;
          }
          trava[i]-=0.04;
        }
        for(int i=0;i<mehuric.length;i++) {
          if(mehuric[i]<-2){
            mehuric[i]+= 3.1;
          }
          mehuric[i]-= 0.035;
        }

        if(ribe1<-2){
          ribe1+= 5;
        }
        ribe1-= 0.055;
        if(ribe2<-2){
          ribe2+= 6;
        }
        ribe2-= 0.055;

      });
      if (ribaYaxis<-1 || ribaYaxis>1|| checkLose()) {
        timer.cancel();
        _showDialog();
      }
    });
  }

  void howToPlay(){
    ind=0;
    howToPlayProzor=true;
    showDialog(
        barrierDismissible: ind==0 ? false : true,
        context: context,
        builder: (BuildContext context){
          return AlertDialog(
            backgroundColor: Colors.green[600],
            title: Text(
              "KAKO SE IGRA",
              style: TextStyle(color: Colors.white),
              textAlign: TextAlign.center,
            ),
            content: Text(
              "Zagadjenost u morima je veliki problem današnjice. "
                  "Pomozite ribicama Daci, Vanji, Bojku i Mikiju da sakupe novac za čišćenje okeana. "
                  "Dogovor je takav da na svakih 100 novčića, iz mora bude izvađena 1 tona otpada. "
                  "Budite oprezni: trava i ostale morske životinje pokušaće da spreče ribice u njihovoj misiji."
                  "\n\nKorisiti klik ili space."
                  "\n\nPoeni:"
                  "\nvertikalne prepreke: +1"
                  "\nnovčići: +3"
                  "\nplastika: -2"
                  "\n\nDaca: Srećno!"
                  "\nVanja: Hvala na pomoći!"
                  "\nBojko: Pažljivo plivajte!"
                  "\nMiki: Smanjite upotrebu plastike, molim lepo!",
              style: TextStyle(color: Colors.white),
            ),
            actions: [
              TextButton(
                child: Text(
                  "OK",
                  style: TextStyle(
                      color: Colors.white,
                      backgroundColor: Colors.green[800]),
                ),
                onPressed: () {
                  ind=1;
                  howToPlayProzor=false;
                  Navigator.of(context).pop();
                },
              ),
              RawKeyboardListener(
                  autofocus: true,
                  focusNode: FocusNode(),
                  onKey: (event) {
                    if (event.isKeyPressed(LogicalKeyboardKey.space)) {
                      howToPlayProzor=false;
                      Navigator.of(context).pop();
                    }
                  },
                  child: Text("")
              )
            ],
          );
        }
    );
  }

  void _showDialog() {
    ind=0;
    showDialog(
        barrierDismissible: ind==0 ? false : true,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Colors.green[600],
            title:Text(
              "KRAJ IGRE",
              style: TextStyle(color: Colors.white),
              textAlign: TextAlign.center,
            ),
            //kraj igre
            content: Text(
              "rezultat: " + rezultat.toString()+"\nskupljeno novčića: "+  ukupnoNovcica.toStringAsFixed(0),
              style: TextStyle(color: Colors.white),
            ), //rezultat
            actions: [
              TextButton(
                child: Text(
                  "IGRAJ PONOVO",
                  style: TextStyle(
                      color: Colors.white,
                      backgroundColor: Colors.green[800]),
                ),
                onPressed: () {
                  ind=1;
                  if (rezultat > najboljiRezultat) {
                    najboljiRezultat = rezultat;
                  }
                  initState();
                  setState(() {
                    gameHasStarted = false;
                  });
                  Navigator.of(context).pop();
                },
              ),
              RawKeyboardListener(
                  autofocus: true,
                  focusNode: FocusNode(),
                  onKey: (event) {
                    if (event.isKeyPressed(LogicalKeyboardKey.space)) {
                      if (rezultat > najboljiRezultat) {
                        najboljiRezultat = rezultat;
                      }
                      initState();
                      setState(() {
                        gameHasStarted = false;
                      });
                      Navigator.of(context).pop();
                    }
                  },
                  child: Text("")
              )
            ],
          );
        }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [
         RawKeyboardListener(
        autofocus: true,
        focusNode: FocusNode(),
        onKey: (event) {
          if (event.isKeyPressed(LogicalKeyboardKey.space)) {
            if (gameHasStarted) {
              jump();
            } else if(!gameHasStarted && howToPlayProzor==false){
              startGame();
            }
          }
        },
        child:GestureDetector(
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
                      flex: 6,
                      child: Stack(
                        children: [
                          Container(
                            decoration: const BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage("lib/slike/blue.jpg"),
                                  fit: BoxFit.cover),
                            ),
                          ),//pozadina
                          AnimatedContainer(
                              alignment: Alignment(0, ribaYaxis),
                              duration: Duration(milliseconds: 0),
                              child: MyRiba(indr:indRibe)
                          ),//riba

                          MyNovcic(x:novcic1, y:-0.5),//novcic1
                          MyNovcic(x:novcic2, y:0.5),//novcic2
                          MyNovcic(x:novcic3, y:-0.4),//novcic3

                          MyPlastika(ind:1,x:kesa),//kesa
                          MyPlastika(ind:2,x:flasa),//flasa
                          MyPlastika(ind:3,x:casa),//casa

                          MyOrka(x:orka), //orka
                          MyKraba(x:kraba), //kraba

                          MyPrepreka(ind:2,size:220.0,x:prepreke[0],y:1.1),//pd1
                          MyPrepreka(ind:2,size:200.0,x:prepreke[1],y:1.1),//pd2
                          MyPrepreka(ind:2,size:200.0,x:prepreke[2],y:1.1),//pd3
                          MyPrepreka(ind:2,size:200.0,x:prepreke[3],y:1.1),//pd4
                          MyPrepreka(ind:1,size:300.0,x:prepreke[0],y:-1.3),//pg1
                          MyPrepreka(ind:1,size:300.0,x:prepreke[1],y:-1.5),//pg2
                          MyPrepreka(ind:1,size:300.0,x:prepreke[2],y:-1.7),//pg3

                          Container(
                            alignment: Alignment(0, -0.3),
                            child: gameHasStarted || igraJeUToku ? Text("") : Text("Z A P O Č N I   I G R U",
                                style:
                                TextStyle(fontSize: 20, color: Colors.white)),
                          ),//zapocni igru
                          Container(
                            alignment: Alignment(0,0),
                            child: !gameHasStarted && igraJeUToku ? Text("N A S T A V I   I G R U",
                                style:
                                TextStyle(fontSize: 20, color: Colors.white))
                                : Text(" "),
                          ),
                          gameHasStarted || igraJeUToku ? Text("") :
                          Container(
                            alignment: Alignment(0,0.3),
                            child: ElevatedButton(
                              child: Text(
                                "K A K O   S E   I G R A",
                                style: TextStyle(fontSize: 15, color: Colors.white),
                              ),
                              onPressed: () {
                                howToPlay();
                              },
                            ),
                          ),
                          ukupnoNovcica<300 || gameHasStarted ? Text("") :
                          Container(
                            alignment: Alignment(0,0.5),
                            child: ElevatedButton(
                              child: Text(
                                  "I G R A J   I S P O Č E T K A",
                                  style: TextStyle(color:Colors.white),
                                  textAlign: TextAlign.right),
                              onPressed: () {
                                indNovcici=0;
                                ukupnoNovcica=0;
                                initState();
                                setState(() {
                                  gameHasStarted = false;
                                });
                              },
                            ),
                          ),

                          AnimatedContainer(
                              alignment: Alignment(ribe1,-0.8),
                              duration: Duration(milliseconds: 0),
                              child:Image.asset(
                                'lib/slike/ribe1.png',
                                height:80,
                              )
                          ),//ribe1
                          AnimatedContainer(
                              alignment: Alignment(ribe2,0.7),
                              duration: Duration(milliseconds: 0),
                              child:Image.asset(
                                'lib/slike/ribe2.png',
                                height:80,
                              )
                          ),//ribe2
                          MyTrava(x:trava[0],y:1.14),
                          MyTrava(x:trava[1],y:1.14),
                          MyTrava(x:trava[2],y:1.14),
                          MyTrava(x:trava[3],y:1.14),
                          MyTrava(x:trava[4],y:1.14),
                          MyMehuric(x:mehuric[0],y:-0.5),
                          MyMehuric(x:mehuric[1],y:-0.8),
                          MyMehuric(x:mehuric[2],y:-0.1),
                          MyMehuric(x:mehuric[3],y:0.9),
                          MyMehuric(x:mehuric[4],y:0.55),
                          MyMehuric(x:mehuric[5],y:0.5),
                          MyMehuric(x:mehuric[6],y:-0.6),
                          MyMehuric(x:mehuric[7],y:0.6),
                          MyMehuric(x:mehuric[8],y:-0.7),
                          MyMehuric(x:mehuric[9],y:0.3),

                          //promeni ribu
                          gameHasStarted ? Text("") :
                          Column(
                            children: [
                              Text("\n    P R O M E N I   R I B U   ",
                                style:
                                TextStyle(color: Colors.white, fontSize: 15),
                              ),
                              IconButton(
                                //alignment: Alignment(0,1),
                                icon: Image.asset('lib/slike/riba.png'),
                                iconSize: 60,
                                onPressed: () {
                                  indRibe=1;
                                  setState(() {
                                    gameHasStarted = false;
                                  });
                                },
                              ),
                              IconButton(
                                icon: Image.asset('lib/slike/riba2.png'),
                                iconSize: 60,
                                onPressed: () {
                                  indRibe=2;
                                  setState(() {
                                    gameHasStarted = false;
                                  });
                                },
                              ),
                              IconButton(
                                icon: Image.asset('lib/slike/riba3.png'),
                                iconSize: 60,
                                onPressed: () {
                                  indRibe=3;
                                  setState(() {
                                    gameHasStarted = false;
                                  });
                                },
                              ),
                              IconButton(
                                icon: Image.asset('lib/slike/riba4.png'),
                                iconSize: 70,
                                onPressed: () {
                                  indRibe=4;
                                  setState(() {
                                    gameHasStarted = false;
                                  });
                                },
                              ),
                            ],
                          ),

                        ],
                      )),
                  Expanded(
                    child: Container(
                      color: Colors.orange[200],
                      child: Stack(
                        children:[
                          Positioned.fill(
                            child: Image.asset(
                              'lib/slike/kamenje.png',
                              repeat: ImageRepeat.repeat,
                            ),
                          ),
                          gameHasStarted || igraJeUToku ?
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text("REZULTAT",
                                      style:
                                      TextStyle(color: Colors.black, fontSize: 20,backgroundColor: Colors.orange[200])),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Text(rezultat.toString(),
                                      style:
                                      TextStyle(color: Colors.black, fontSize: 35, backgroundColor: Colors.orange[200])),
                                ],
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text("SKUPLJENO NOVČIĆA",
                                      style:
                                      TextStyle(color: Colors.black, fontSize: 20, backgroundColor: Colors.orange[200])),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Text(ukupnoNovcica.toString(),
                                      style:
                                      TextStyle(color: Colors.black, fontSize: 35, backgroundColor: Colors.orange[200])),
                                ],
                              ),
                            ],
                          )
                              :
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text("NAJBOLJI REZULTAT",
                                      style:
                                      TextStyle(color: Colors.black, fontSize: 20, backgroundColor: Colors.orange[200])),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Text(najboljiRezultat.toString(),
                                      style:
                                      TextStyle(color: Colors.black, fontSize: 35, backgroundColor: Colors.orange[200])),
                                ],
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text("SKUPLJENO NOVČIĆA",
                                      style:
                                      TextStyle(color: Colors.black, fontSize: 20, backgroundColor: Colors.orange[200])),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Text(ukupnoNovcica.toString(),
                                      style:
                                      TextStyle(color: Colors.black, fontSize: 35, backgroundColor: Colors.orange[200])),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        )
        ],
      ),
    );
  }
}
