import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
        debugShowCheckedModeBanner: false, home: Tic_Tac_Toe());
  }
}

class Tic_Tac_Toe extends StatefulWidget {
  const Tic_Tac_Toe({super.key});

  @override
  State<Tic_Tac_Toe> createState() => _Tic_Tac_ToeState();
}

class _Tic_Tac_ToeState extends State<Tic_Tac_Toe> {
  bool oTurn = true;
  List<String> xorO = ['', '', '', '', '', '', '', '', ''];
  var style = TextStyle(color: Colors.white, fontSize: 30);
  int xScore = 0;
  int oScore = 0;
  int filledbox = 0;
  static var newFont = GoogleFonts.pressStart2p(
      textStyle: TextStyle(color: Colors.black, letterSpacing: 3));
  static var newwhiteFont = GoogleFonts.pressStart2p(
      textStyle: TextStyle(color: Colors.white, letterSpacing: 3),
      fontSize: 15);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 77, 75, 75),
      body: Column(
        children: <Widget>[
          Expanded(
              child: Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'PlayerX',
                        style: newwhiteFont,
                      ),
                      Text(
                        xScore.toString(),
                        style: newwhiteFont,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'PlayerO',
                        style: newwhiteFont,
                      ),
                      Text(
                        oScore.toString(),
                        style: newwhiteFont,
                      ),
                    ],
                  ),
                )
              ],
            ),
          )),
          Expanded(
            flex: 3,
            child: GridView.builder(
                itemCount: 9,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3),
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () => _tapped(index),
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: const Color.fromARGB(255, 0, 0, 0))),
                      child: Center(
                        child: Text(
                          xorO[index],
                          style: TextStyle(color: Colors.white, fontSize: 30),
                        ),
                      ),
                    ),
                  );
                }),
          ),
          Expanded(
              child: Container(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 80),
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            elevation: 5,
                            foregroundColor: Colors.black,
                            backgroundColor: Colors.black12,
                            minimumSize: Size(200, 50),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(0),
                            )),
                        onPressed: _clearScoreBoard,
                        child: Text(
                          'Reset',
                          style: newwhiteFont,
                        )),
                  ),
                  SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Text(
                      'TIC TAC TOE',
                      style: newwhiteFont,
                    ),
                  )
                ],
              ),
            ),
          )),
        ],
      ),
    );
  }

  void _tapped(int index) {
    setState(() {
      if (oTurn && xorO[index] == '') {
        xorO[index] = 'O';
        filledbox += 1;
      } else if (!oTurn && xorO[index] == '') {
        xorO[index] = 'X';
        filledbox += 1;
      }
      oTurn = !oTurn;
      _checkWinner();
    });
  }

  void _checkWinner() {
    //row1
    if (xorO[0] == xorO[1] && xorO[0] == xorO[2] && xorO[0] != '') {
      _showDialog(xorO[0]);
    }
    //row2
    if (xorO[3] == xorO[4] && xorO[3] == xorO[5] && xorO[3] != '') {
      _showDialog(xorO[3]);
    }
    //row3
    if (xorO[6] == xorO[7] && xorO[6] == xorO[8] && xorO[6] != '') {
      _showDialog(xorO[6]);
    }
    //col1
    if (xorO[0] == xorO[3] && xorO[0] == xorO[6] && xorO[0] != '') {
      _showDialog(xorO[0]);
    }
    //col2
    if (xorO[1] == xorO[4] && xorO[1] == xorO[7] && xorO[1] != '') {
      _showDialog(xorO[1]);
    }
    //col3
    if (xorO[2] == xorO[5] && xorO[2] == xorO[8] && xorO[2] != '') {
      _showDialog(xorO[2]);
    }
    //diagnol1
    if (xorO[0] == xorO[4] && xorO[0] == xorO[8] && xorO[0] != '') {
      _showDialog(xorO[0]);
    }
    //diagnol2
    if (xorO[2] == xorO[4] && xorO[2] == xorO[6] && xorO[2] != '') {
      _showDialog(xorO[2]);
    } else if (filledbox == 9) {
      _showDrawDialog();
      return;
    }
  }

  void _showDrawDialog() {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('DRAW'),
            actions: [
              ElevatedButton(
                child: Text("Play Again!"),
                onPressed: () {
                  _clear();
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }

  void _showDialog(String winner) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(winner + ' has won the game.'),
            actions: [
              ElevatedButton(
                child: Text("Play Again!"),
                onPressed: () {
                  _clear();
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
    if (winner == 'O') {
      oScore += 1;
    } else {
      xScore += 1;
    }
  }

  void _clear() {
    setState(() {
      for (int i = 0; i < 9; i++) {
        xorO[i] = '';
      }
    });
    filledbox = 0;
  }

  void _clearScoreBoard() {
    setState(() {
      xScore = 0;
      oScore = 0;
      for (int i = 0; i < 9; i++) {
        xorO[i] = '';
      }
    });
    filledbox = 0;
  }
}
