class Validator {
  final List<String> reason = [];
  Validator();
  //check column if Queen is Exist in
  bool _checkColumn(List<List<String>> board, int column) {
    for (int i = 0; i < 8; i++) {
      if (board[i][column] == 'Q') {
        reason.add('Queen treated by Queen in [$i][$column] place');
        return false;
      }
    }
    return true;
  }

  bool _checkRow(List<List<String>> board, int row) {
    for (int j = 0; j < 8; j++) {
      if (board[row][j] == 'Q') {
        reason.add('Queen treated by Queen in [$row][$j] place');
        return false;
      }
    }
    return true;
  }

  bool _checkDiagonals(List<List<String>> board, int row, int column) {
    int i = row;
    int j = column;

    bool finalResult = true;
    // down and right movement
    while (i != board.length && j != board.length) {
      if (board[i][j] == 'Q') {
        reason.add('Queen treated by Queen in [$i][$j] place');
        // if we want all results so we dont return after find problem
        // and just change the final result
        finalResult = false;
      }
      i++;
      j++;
    }
    // down and left movement
    i = row;
    j = column;
    while (i != -1 && j != board.length) {
      if (board[i][j] == 'Q') {
        reason.add('Queen treated by Queen in [$i][$j] place');
        finalResult = false;
      }
      i--;
      j++;
    }
    // up and right movement
    i = row;
    j = column;
    while (i != board.length && j != -1) {
      if (board[i][j] == 'Q') {
        reason.add('Queen treated by Queen in [$i][$j] place');
        finalResult = false;
      }
      i++;
      j--;
    }
    // up and left movement
    i = row;
    j = column;
    while (i != -1 && j != -1) {
      if (board[i][j] == 'Q') {
        reason.add('Queen treated by Queen in [$i][$j] place');
        finalResult = false;
      }
      i--;
      j--;
    }

    return finalResult;
  }

  bool isValidatePlacement(
      List<List<String>> board, int currentRow, int currentColumn) {
    // when we use and in a condition it stops 
    // when it faced with the first wrong 
    // so we can't use it because we want the final result
    // to show to user as you said in your document;
    bool columnChecker = _checkColumn(board, currentColumn);
    bool rowChecker = _checkRow(board, currentRow);
    bool diagonalsChecker = _checkDiagonals(board, currentRow, currentColumn);
    if(columnChecker &&rowChecker &&  diagonalsChecker){
      return true;
    }
    return false;
  }
}
