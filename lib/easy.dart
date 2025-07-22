import 'package:flutter/material.dart';
import 'players.dart';

class Easy extends StatefulWidget {
  const Easy({super.key});

  @override
  State<Easy> createState() => _EasyState();
}

class _EasyState extends State<Easy> {
  bool oTurn = true; // first player is O
  List<String> displayElement = ['', '', '', '', '', '', '', '', ''];
  int oScore = 0;
  int xScore = 0;
  int filledBoxes = 0;

  @override
  Widget build(BuildContext context) {
    Players players = ModalRoute.of(context)!.settings.arguments as Players;
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: <Widget>[
          // creating the ScoreBoard
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        players.toStringPlayerX(),
                        style: const TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: Colors.red),
                      ),
                      Text(
                        xScore.toString(),
                        style: const TextStyle(fontSize: 30, color: Colors.red),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                          players.toStringPlayerO(),
                          style: const TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              color: Colors.green)),
                      Text(
                        oScore.toString(),
                        style:
                        const TextStyle(fontSize: 30, color: Colors.green),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(oTurn ? 'O Turn' : 'X Turn', style: const TextStyle(color: Colors.cyanAccent, fontSize: 30.0),)
                ],
              )
          ),
          Expanded(
            // Creating the Board
            flex: 3,
            child: GridView.builder(
                itemCount: 9,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3),
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () {
                      tapped(index);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: Colors.cyanAccent, width: 10.0)),
                      child: Center(
                        child: Text(
                          displayElement[index],
                          style: TextStyle(
                              color: displayElement[index] == 'X'
                                  ? Colors.red
                                  : Colors.green,
                              fontSize: 50,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  );
                }),
          ),
          Expanded(
            // Button for Clearing the Enter board
            // as well as Scoreboard to start allover again
              child: Column(children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.cyanAccent,
                        foregroundColor: Colors.black,
                      ),
                      onPressed: clearScoreBoard,
                      child: const Text(
                        "Restart",
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.cyanAccent,
                        foregroundColor: Colors.black,
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text(
                        "Home",
                        style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                )
              ]))
        ],
      ),
    );
  }

  void tapped(int index) {
    setState(() {
      if (oTurn && displayElement[index] == '') {
        displayElement[index] = 'O';
        oTurn = false;
        filledBoxes++;
      } else if (!oTurn && displayElement[index] == '') {
        displayElement[index] = 'X';
        oTurn = true;
        filledBoxes++;
      }
      checkWinner();
    });
  }

  void showWinDialog(String winner) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: oTurn ? Colors.red : Colors.green,
            title: Text(
              '(($winner)) WINNER!!!',
              style: const TextStyle(color: Colors.cyanAccent),
            ),
            actions: [
              TextButton(
                child: const Text(
                  "Play Again",
                  style: TextStyle(
                    color: Colors.cyanAccent,
                  ),
                ),
                onPressed: () {
                  clearBoard();
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });

    if (winner == 'O') {
      oScore++;
    } else if (winner == 'X') {
      xScore++;
    }
  }

  void showDrawDialog() {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Colors.black,
            title: const Text(
              "Draw",
              style: TextStyle(fontSize: 27.0, color: Colors.cyanAccent),
            ),
            actions: [
              TextButton(
                child: const Text(
                  "Play Again",
                  style: TextStyle(fontSize: 15.0, color: Colors.cyanAccent),
                ),
                onPressed: () {
                  clearBoard();
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }

  void clearBoard() {
    setState(() {
      for (int i = 0; i < 9; i++) {
        displayElement[i] = '';
      }
    });
    filledBoxes = 0;
  }

  void clearScoreBoard() {
    setState(() {
      xScore = 0;
      oScore = 0;
      oTurn = true;
    });
    clearBoard();
  }

  void checkWinner() {
    // Checking rows
    if (displayElement[0] == displayElement[1] &&
        displayElement[0] == displayElement[2] &&
        displayElement[0] != '') {
      showWinDialog(displayElement[0]);
    }
    if (displayElement[3] == displayElement[4] &&
        displayElement[3] == displayElement[5] &&
        displayElement[3] != '') {
      showWinDialog(displayElement[3]);
    }
    if (displayElement[6] == displayElement[7] &&
        displayElement[6] == displayElement[8] &&
        displayElement[6] != '') {
      showWinDialog(displayElement[6]);
    }

    // Checking Column
    if (displayElement[0] == displayElement[3] &&
        displayElement[0] == displayElement[6] &&
        displayElement[0] != '') {
      showWinDialog(displayElement[0]);
    }
    if (displayElement[1] == displayElement[4] &&
        displayElement[1] == displayElement[7] &&
        displayElement[1] != '') {
      showWinDialog(displayElement[1]);
    }
    if (displayElement[2] == displayElement[5] &&
        displayElement[2] == displayElement[8] &&
        displayElement[2] != '') {
      showWinDialog(displayElement[2]);
    }

    // Checking Diagonal
    if (displayElement[0] == displayElement[4] &&
        displayElement[0] == displayElement[8] &&
        displayElement[0] != '') {
      showWinDialog(displayElement[0]);
    }
    if (displayElement[2] == displayElement[4] &&
        displayElement[2] == displayElement[6] &&
        displayElement[2] != '') {
      showWinDialog(displayElement[2]);
    } else if (filledBoxes == 9) {
      showDrawDialog();
    }
  }
}
