import 'dart:html';

import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tic Tac Toe Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Tic Tac Toe Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _turn = 0;
  String _player = "X";
  var boxes = [' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '];
  bool _gameEnd = false;
  String _winnerText = " ";

  void _handleTap(int index) {
    setState(() {
      if (!_gameEnd) {
        if (_turn % 2 == 0) _player = "X";
        if (_turn % 2 == 1) _player = "O";

        if (boxes[index] == ' ') {
          boxes[index] = _player;
          _winCondition();
          _turn++;
        }
      }
    });
  }

  void _winCondition() {
    if (boxes[0] == boxes[1] &&
        boxes[0] == boxes[2] &&
        boxes[0] != ' ' &&
        boxes[1] != ' ') _gameEnd = true;
    if (boxes[3] == boxes[4] &&
        boxes[3] == boxes[5] &&
        boxes[3] != ' ' &&
        boxes[4] != ' ') _gameEnd = true;
    if (boxes[6] == boxes[7] &&
        boxes[6] == boxes[8] &&
        boxes[6] != ' ' &&
        boxes[7] != ' ') _gameEnd = true;
    if (boxes[0] == boxes[3] &&
        boxes[3] == boxes[6] &&
        boxes[0] != ' ' &&
        boxes[3] != ' ') _gameEnd = true;
    if (boxes[1] == boxes[4] &&
        boxes[4] == boxes[7] &&
        boxes[1] != ' ' &&
        boxes[4] != ' ') _gameEnd = true;
    if (boxes[2] == boxes[5] &&
        boxes[5] == boxes[8] &&
        boxes[2] != ' ' &&
        boxes[5] != ' ') _gameEnd = true;
    if (boxes[0] == boxes[4] &&
        boxes[4] == boxes[8] &&
        boxes[0] != ' ' &&
        boxes[4] != ' ') _gameEnd = true;
    if (boxes[2] == boxes[4] &&
        boxes[4] == boxes[6] &&
        boxes[2] != ' ' &&
        boxes[4] != ' ') _gameEnd = true;

    if (_gameEnd) _winner();

    if (_turn == 8 && !_gameEnd) {
      _winnerText = "Draw!";
      _gameEnd = true;
    }
  }

  void _reset() {
    setState(() {
      _turn = 0;
      _player = "X";
      _gameEnd = false;
      for (int i = 0; i < 9; i++) boxes[i] = ' ';
    });
  }

  void _winner() {
    setState(() {
      if (_turn % 2 == 0) _winnerText = "X Wins!";
      if (_turn % 2 == 1) _winnerText = "O Wins!";
    });
  }

  Widget _GameArea(BuildContext context) {
    return GridView.count(
      // Create a grid with 3 columns. If you change the scrollDirection to
      // horizontal, this produces 3 rows.
      crossAxisCount: 3,
      // Generate 9 widgets that display their index in the List.
      children: List.generate(9, (index) {
        return GestureDetector(
          onTap: () =>
              [_handleTap(index), if (_gameEnd) showAlertDialog(context)],
          child: Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
                border: Border.all(color: Colors.black, width: 0.5)),
            child: Text(
              boxes[index],
              style: TextStyle(
                fontSize: 50.0,
              ),
            ),
          ),
        );
      }),
    );
  }

  showAlertDialog(BuildContext context) {
    // set up the button

    Widget okButton = TextButton(
      onPressed: _reset,
      child: Text("Restart"),
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("End of the game"),
      content: Text(_winnerText),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text(widget.title), actions: <Widget>[
          Padding(
              padding: EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                onTap: _reset,
                child: Icon(
                  Icons.restart_alt,
                  size: 26.0,
                ),
              )),
        ]),
        body: Column(
          children: <Widget>[
            Flexible(
              child: _GameArea(context),
            ),
          ],
        ));
  }
}
