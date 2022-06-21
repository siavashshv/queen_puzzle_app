import 'package:flutter/material.dart';
import 'package:eight_queens_game/Theme.dart';

import 'chess.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: QueenPuzzleApp(),
    );
  }
}

class QueenPuzzleApp extends StatelessWidget {
  const QueenPuzzleApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Queen Puzzle'),
        titleTextStyle: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w500,
            color: AppColors.darkBox),
        backgroundColor: AppColors.takenBox,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Center(
            child: Container(
              margin: EdgeInsets.only(top: 30),
              child: ChessTable(),
            ),
          ),
        ),
      ),
    );
  }
}
