import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}


class _HomePageState extends State<HomePage> {
  
bool ohTurn =  true; // fisrt person

  List<String> displayExOh = ['','','','','','','','','',];

  var MyTextStyle  = TextStyle(color: Colors.green,fontSize: 30);
  int oScore = 0;
  int xScore = 0;
  int filledBoxes =0;

  static var myNewFont = GoogleFonts.pressStart2p(
    textStyle :TextStyle(color:Colors.black, letterSpacing: 3)
  );
  static var myNewFontWhite = GoogleFonts.pressStart2p(
    textStyle : TextStyle(color: Colors.red, letterSpacing: 3, fontSize: 15)
  );
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children:<Widget> [
          Expanded(
            child: Container(
              child: Row(
                mainAxisAlignment:MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Player x', style: myNewFontWhite,),
                        Text(xScore.toString(),style: myNewFontWhite,)
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Player o',style: myNewFontWhite,),
                        Text(oScore.toString(),style: myNewFontWhite,)
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
              itemCount:9 ,
                gridDelegate:
                    SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
                itemBuilder: (BuildContext context , int index){
                  return GestureDetector(
                    onTap: (){
                      _tapped(index);
                    },
                    child: Container(
                      decoration:BoxDecoration(
                        border: Border.all(color:Color.fromARGB(255, 255, 0, 0))
                      ),
                      child: Center(
                        child: Text(displayExOh[index], style: TextStyle(color: Colors.red, fontSize: 40),),
                      )
                    ),
                  );
                }),
          ),
        ],
      ),
    );
  }
  void _tapped(int index){
    setState(() {
      if(ohTurn && displayExOh[index] == ''){
        displayExOh[index] = 'o';
        filledBoxes +=1;
      }else if (!ohTurn && displayExOh[index] == ''){
        displayExOh[index] = 'x';
        filledBoxes+=1;
      }
      ohTurn =! ohTurn;
      _checkWinner();
    });
  }

  void _checkWinner(){
    // check 1st row
    if(displayExOh[0] == displayExOh[1]&& 
       displayExOh[0] == displayExOh[2]&& 
       displayExOh[0] != ''){
      _showWinDialog(displayExOh[0]);
    }
    //check 2nd row
    if(displayExOh[3] == displayExOh[4]&& 
       displayExOh[3] == displayExOh[5] && 
       displayExOh[3] != ''){
      _showWinDialog(displayExOh[3]);
    }
    //check 3rd row 
    if(displayExOh[6] == displayExOh[7]&& 
       displayExOh[6] == displayExOh[8]&& 
       displayExOh[6] != ''){
      _showWinDialog(displayExOh[6]);
    }
    //check 1st column 
    if(displayExOh[0] == displayExOh[3]&& 
       displayExOh[0] == displayExOh[6]&& 
       displayExOh[0] != ''){
      _showWinDialog(displayExOh[0]);
    }
    //check 2nd column
    if(displayExOh[1] == displayExOh[4]&& 
       displayExOh[1] == displayExOh[7]&& 
       displayExOh[1] != ''){
      _showWinDialog(displayExOh[1]);
    }
    //check 3rd column
    if(displayExOh[2] == displayExOh[5]&& 
       displayExOh[2] == displayExOh[8]&& 
       displayExOh[2] != ''){
      _showWinDialog(displayExOh[2]);
    }
    //check diagonal 1
    if(displayExOh[6] == displayExOh[4]&& 
       displayExOh[6] == displayExOh[2]&& 
       displayExOh[6] != ''){
      _showWinDialog(displayExOh[6]);
    }
    //check diagonal 2
    if(displayExOh[0] == displayExOh[4]&& 
       displayExOh[0] == displayExOh[8]&& 
       displayExOh[0] != ''){
      _showWinDialog(displayExOh[0]);
    }
    else if(filledBoxes ==9){
      showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context){
          return AlertDialog(
            title: Text('Draw'),
            actions: <Widget>[
              ElevatedButton(
                child: Text('Play Again!'),
                onPressed : (){
                  _clearBoard();
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        },
      );
    }

  }

    void _showDrawDialog(String winner){
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context){
        return AlertDialog(
          title: Text('Draw'),
          actions: <Widget>[
            ElevatedButton(
              child: Text('Play Again!'),
              onPressed : (){
                _clearBoard();
                Navigator.of(context).pop();
              },
            )
          ],
        );
      },
    );
  }

  void _showWinDialog(String winner){
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context){
        return AlertDialog(
          actions: <Widget>[
            ElevatedButton(
              child: Text('Play Again'),
              onPressed : (){
                _clearBoard();
                Navigator.of(context).pop();
              },
            ),
          ],
          title: Text('winner is:'+winner)
        );
      }
    );
  if(winner == 'o'){
    oScore+=1;
  }else if(winner == 'x'){
    xScore +=1;
  }
  _clearBoard();
  }

  void _clearBoard()
  {
    setState(() {
      for(int i=0;i<9;i++){
        displayExOh[i]= '';
      }
    });

    filledBoxes =0;
  }


}

