
import 'package:flutter/material.dart';
import 'package:qadiroon_front_end/simple_alert_widgets.dart';
import 'package:qadiroon_front_end/styled%20widgets/styled_text.dart';
import 'package:qadiroon_front_end/tools/query_tools.dart';

class BeneficiaryGameScreen extends StatefulWidget
{
 
  State<BeneficiaryGameScreen> createState()
  {
    return _BeneficiaryGameScreenState();
  }
  
}

class _BeneficiaryGameScreenState extends State<BeneficiaryGameScreen>
{

  // -1 = empty, 0 = X, 1 = O
   List<int> Board = 
   [
    -1, -1, -1,
    -1, -1, -1,
    -1, -1, -1
   ];
  // true = X, false = O
  bool _currentTurn = true;

  var IconsMap = 
  {
    -1 : Icon(Icons.square_outlined),
    0 : Icon(Icons.add),
    1 : Icon(Icons.circle_outlined)
  };

  void updateBoard(int position)
  {
    Board[position] = (_currentTurn)? 0 : 1;
    setState(() {});
    BusyWait(2000
    );
    if(checkWinner())
    {
      resetBoard();
    }
    else
    {
      _currentTurn = !_currentTurn;
    }
  }

  // checks for a finished game
  //TODO: change name
  bool checkWinner()
  {
    if
    (
      (Board[0] == Board[1] && Board[1] == Board[2] && Board[0] != -1)
      ||
      (Board[3] == Board[4] && Board[4] == Board[5] && Board[3] != -1)
      ||
      (Board[6] == Board[7] && Board[7] == Board[8] && Board[6] != -1)
      ||
      (Board[0] == Board[3] && Board[3] == Board[6] && Board[0] != -1)
      ||
      (Board[1] == Board[4] && Board[4] == Board[7] && Board[1] != -1)
      ||
      (Board[2] == Board[5] && Board[5] == Board[8] && Board[2] != -1)
      ||
      (Board[0] == Board[4] && Board[4] == Board[8] && Board[0] != -1)
      ||
      (Board[2] == Board[4] && Board[4] == Board[6] && Board[2] != -1)
    )
    {
      String winner = (_currentTurn)? 'X': 'O';
      simple_alert_showWidget(context, '$winner فاز الـ');
      return true;
    }
    else if(Board.contains(-1) == false)
    {
      simple_alert_showWidget(context, 'تعادل');
      return true;
    }
    return false;
  }

  void resetBoard()
  {
    _currentTurn = true;
    Board = 
    [
      -1, -1, -1,
      -1, -1, -1,
      -1, -1, -1
    ];
    setState(() {});
  }

  Widget build(BuildContext context)
  {
    return Scaffold
    (
      backgroundColor: Colors.blueGrey.shade200,
      body: Column
    (
      children: 
      [
        StyledText(text: ':العب اكس أو', size: 36, color: Colors.black87, fontFamily: 'Amiri'),
        SizedBox(height: 32,),
        StyledText(text: '${(_currentTurn)? 'X' : 'O'}  :دَوْر', size: 32, color: Colors.indigo, fontFamily: 'Amiri'),
        Spacer(),
        Row
        (
          children: 
          [
            Spacer(),
            IconButton(onPressed: (){updateBoard(0);}, icon: IconsMap[Board[0]]!),
            Spacer(),
            IconButton(onPressed: (){updateBoard(1);}, icon: IconsMap[Board[1]]!),
            Spacer(),
            IconButton(onPressed: (){updateBoard(2);}, icon: IconsMap[Board[2]]!),
            Spacer()
          ],
        ),
        Spacer(),
        Row
        (
          children: 
          [
            Spacer(),
            IconButton(onPressed: (){updateBoard(3);}, icon: IconsMap[Board[3]]!),
            Spacer(),
            IconButton(onPressed: (){updateBoard(4);}, icon: IconsMap[Board[4]]!),
            Spacer(),
            IconButton(onPressed: (){updateBoard(5);}, icon: IconsMap[Board[5]]!),
            Spacer()
          ],
        ),
        Spacer(),
        Row
        (
          children: 
          [
            Spacer(),
            IconButton(onPressed: (){updateBoard(6);}, icon: IconsMap[Board[6]]!),
            Spacer(),
            IconButton(onPressed: (){updateBoard(7);}, icon: IconsMap[Board[7]]!),
            Spacer(),
            IconButton(onPressed: (){updateBoard(8);}, icon: IconsMap[Board[8]]!),
            Spacer()
          ],
        ),
        Spacer()
      ],
    ),
    );
  }
  
}