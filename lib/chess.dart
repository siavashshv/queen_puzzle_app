import 'dart:math';

import 'package:eight_queens_game/validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:eight_queens_game/Theme.dart';

// ignore: must_be_immutable
class ChessTable extends StatefulWidget {
  final int chessTableLength = 8;
  int queens = 0;

  @override
  ChessTableState createState() => ChessTableState();
}

class ChessTableState extends State<ChessTable> {
  // Chess items //

  List<List<String>> chessTable = [];

  void _initChessTable() {
    for (int i = 0; i < widget.chessTableLength; i++) {
      List<String> row = [];
      for (int j = 0; j < widget.chessTableLength; j++) {
        row.add('');
      }
      chessTable.add(row);
    }
  }

  @override
  void initState() {
    _initChessTable();
    _makeRandom();
    super.initState();
  }

  Widget buildChessTable() {
    return Column(children: <Widget>[
      AspectRatio(
        aspectRatio: 1.0,
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.0),
              boxShadow: [
                BoxShadow(
                    color: Colors.grey.withOpacity(0.4),
                    offset: Offset(4, 6),
                    blurRadius: 6.0,
                    spreadRadius: 2.0)
              ]),
          child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: widget.chessTableLength),
              itemBuilder: buildTable,
              itemCount: widget.chessTableLength * widget.chessTableLength),
        ),
      ),
    ]);
  }

  Widget buildTable(BuildContext context, int index) {
    int chessTableLength = chessTable.length;
    int row, column = 0;
    row = (index / chessTableLength).floor();
    column = (index % chessTableLength);

    return GestureDetector(
      onTap: () => putAQueen(row, column),
      child: GridTile(
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.darkBox, width: 0.25),
          ),
          child: Center(
            child: MouseRegion(
              cursor: MaterialStateMouseCursor.clickable,
              child: buildGridItems(row, column),
            ),
          ),
        ),
      ),
    );
  }

  void putQueenInPlace(int row, int column) {
    // put Queen in the chessTable and add the count of queens
    Validator validator = Validator();

    if (!validator.isValidatePlacement(chessTable, row, column)) {
      _showError(validator.reason);
      return;
    }

    chessTable[row][column] = 'Q';
    widget.queens++;
    if (widget.queens == widget.chessTableLength) {
      showWinMessage();
    }

    setState(() {});
  }

  void putAQueen(int row, int column) {
    // check here  if the placement is empty//

    if (chessTable[row][column] == 'Q') {
      chessTable[row][column] = '';
      widget.queens--;
      setState(() {});
      return;
    }
    putQueenInPlace(row, column);
  }

  bool isSnackbarActive = false;
  void showWinMessage() {
    if (!isSnackbarActive) {
      isSnackbarActive = true;
      ScaffoldMessenger.of(context)
          .showSnackBar(
            SnackBar(
              content: Padding(
                padding: EdgeInsets.symmetric(vertical: 6.88),
                child: Text(
                  'You Won The Match',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16),
                ),
              ),
              backgroundColor: AppColors.darkBox,
              duration: Duration(milliseconds: 2888),
            ),
          )
          .closed
          .then((SnackBarClosedReason reason) {
        isSnackbarActive = false;
      });
    }
  }

  Container drawQueen(int row, int column) {
    return Container(
      color: ((row % 2 == 0 && column % 2 == 0) ||
              (row % 2 != 0 && column % 2 != 0))
          ? AppColors.darkBox
          : AppColors.lightBox,
      width: double.infinity,
      height: double.infinity,
      child: Center(
        child: Container(
          child: FractionallySizedBox(
            alignment: Alignment.center,
            widthFactor: 0.80,
            heightFactor: 0.80,
            child: SvgPicture.asset(
              "img/queen.svg",
              color: AppColors.takenBox,
            ),
          ),
        ),
      ),
    );
  }

  Container drawSquare(int row, int column) {
    return Container(
        color: ((row % 2 == 0 && column % 2 == 0) ||
                (row % 2 != 0 && column % 2 != 0))
            ? AppColors.darkBox
            : AppColors.lightBox);
  }

  Widget buildGridItems(int row, int column) {
    if (chessTable[row][column] != 'Q') {
      return drawSquare(row, column);
    }
    return drawQueen(row, column);
  }

  void reset() {
    for (int i = 0; i < widget.chessTableLength; i++) {
      for (int j = 0; j < widget.chessTableLength; j++) {
        chessTable[i][j] = '';
      }
    }
    widget.queens = 0;
    setState(() {
      _makeRandom();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(width: MediaQuery.of(context).size.width * 0.05),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: AspectRatio(
              aspectRatio: 1,
              child: Container(
                child: buildChessTable(),
              ),
            ),
          ),
          SizedBox(width: 14.0),
          Padding(
            padding: const EdgeInsets.all(38.0),
            child: Center(
              child: TextButton(
                onPressed: () {
                  reset();
                },
                child: Text(
                  'Reset Game',
                  style: TextStyle(
                      color: AppColors.takenBox,
                      fontSize: 26,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
        ]);
  }

  void _showError(List<String> reason) {
    String resultText = '';
    for (String s in reason) {
      resultText += s + '\n';
    }
    isSnackbarActive = true;
    ScaffoldMessenger.of(context)
        .showSnackBar(
          SnackBar(
            content: Padding(
              padding: EdgeInsets.symmetric(vertical: 6.88),
              child: Text(
                resultText,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16),
              ),
            ),
            backgroundColor: AppColors.darkBox,
            duration: Duration(milliseconds: 2888),
          ),
        )
        .closed
        .then((SnackBarClosedReason reason) {
      isSnackbarActive = false;
    });
  }

  void _makeRandom() {
    int randomRow = Random().nextInt(7);
    int randomColumn = Random().nextInt(7);
    chessTable[randomRow][randomColumn] = 'Q';
    setState(() {});
  }
}
