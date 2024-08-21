import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}
class _HomePageState extends State<HomePage> {

  bool ohTurn = true;
  List<String> displayE = ['', '', '', '', '', '', '', '', '',];

  // var myTextStyle = TextStyle(color: Colors.white, fontSize: 30);
  int oScore = 0;
  int xScore = 0;
  int fillBox = 0;

  static var myNewFont = GoogleFonts.pressStart2p(
      textStyle: TextStyle(color: Colors.black, letterSpacing: 2, fontSize: 12)
  );
  static var myNewFontWhite = GoogleFonts.pressStart2p(
      textStyle: TextStyle(color: Colors.white, letterSpacing: 2, fontSize: 12)
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
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
                        Text('Player 0', style:  myNewFontWhite,),
                        Text(oScore.toString(), style:  myNewFontWhite),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Player X', style: myNewFontWhite),
                        Text(xScore.toString(), style: myNewFontWhite,),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: GridView.builder(
                itemCount: 9,
                gridDelegate:
                SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
                itemBuilder: (BuildContext, int index) {
                  return GestureDetector(
                    onTap: () {
                      _tapped(index);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey)
                      ),
                      child: Center(
                        child: Text(displayE[index],
                            style: TextStyle(color: Colors.white, fontSize: 40)
                        ),
                      ),
                    ),
                  );
                }),
          ),
          Expanded(
            child: Container(
              child: Center(
                child: Column(children: [
                  Text('TIC TAC TOE', style: myNewFontWhite,),
                  SizedBox(height: 60,),
                  Text('Made By: @Janvi', style: myNewFontWhite,),
                ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _tapped(int index) {
    fillBox++;
    setState(() {
      if (ohTurn && displayE[index] == '') {
        displayE[index] = 'o';
      }
      else if(!ohTurn && displayE[index] == ''){
        displayE[index] = 'x';
      }
      else{
        ohTurn = !ohTurn;
        fillBox--;
      }
      ohTurn = !ohTurn;
      _checkWinner();
    });
  }

  void _checkWinner() {
    if (displayE[0] == displayE[1] &&
        displayE[0] == displayE[2] &&
        displayE[0] != '') {
      _showWinDialog(displayE[0]);
    }
    else if (displayE[3] == displayE[4] &&
        displayE[3] == displayE[5] &&
        displayE[3] != '') {
      _showWinDialog(displayE[3]);
    }
    else if (displayE[6] == displayE[7] &&
        displayE[6] == displayE[8] &&
        displayE[6] != '') {
      _showWinDialog(displayE[6]);
    }
    else if (displayE[0] == displayE[3] &&
        displayE[0] == displayE[6] &&
        displayE[0] != '') {
      _showWinDialog(displayE[0]);
    }
    else if (displayE[1] == displayE[4] &&
        displayE[1] == displayE[7] &&
        displayE[1] != '') {
      _showWinDialog(displayE[1]);
    }
    else if (displayE[2] == displayE[5] &&
        displayE[2] == displayE[8] &&
        displayE[2] != '') {
      _showWinDialog(displayE[2]);
    }
    else if (displayE[0] == displayE[4] &&
        displayE[0] == displayE[8] &&
        displayE[0] != '') {
      _showWinDialog(displayE[0]);
    }
    else if (displayE[2] == displayE[4] &&
        displayE[2] == displayE[6] &&
        displayE[2] != '') {
      _showWinDialog(displayE[2]);
    }
    else if(fillBox == 9){
      _showDrawDialog();
    }
  }

  void _showWinDialog(String winner) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('WINNER IS: ' + winner),
            actions: <Widget>[
              TextButton(
                  child: Text('Play Again!'),
                  onPressed: (){
                    _clearBoard();
                    Navigator.of(context).pop();
                  }
              )
            ],
          );
        }
    );
    if(winner == 'o'){
      oScore++;
    }
    else if(winner == 'x'){
      xScore++;
    }
    // _clearBoard()
  }
  void _showDrawDialog() {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('MATCH DRAW!'),
            actions: <Widget>[
              TextButton(
                child: Text('Play Again!'),
                onPressed: () {
                  _clearBoard();
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }
  void _clearBoard(){

    setState(() {
      for(int i=0;i<9;i++){
        displayE[i]='';
      }
    });
    fillBox = 0;
  }
}
