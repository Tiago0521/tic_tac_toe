import 'package:flutter/material.dart';

void main() {
  runApp(const TicTacToeApp());
}

class TicTacToeApp extends StatelessWidget {
  const TicTacToeApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Jogo da Velha',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const TicTacToeGame(),
    );
  }
}

class TicTacToeGame extends StatefulWidget {
  const TicTacToeGame({Key? key}) : super(key: key);

  @override
  _TicTacToeGameState createState() => _TicTacToeGameState();
}

class _TicTacToeGameState extends State<TicTacToeGame> {
  List<String> board = List.filled(9, '');
  bool xTurn = true;

  void _resetGame() {
    setState(() {
      board = List.filled(9, '');
      xTurn = true;
    });
  }

  void _makeMove(int index) {
    if (board[index] == '') {
      setState(() {
        board[index] = xTurn ? 'X' : 'O';
        xTurn = !xTurn;
      });
    }
  }

  String _checkWinner() {
    const winPatterns = [
      [0, 1, 2],
      [3, 4, 5],
      [6, 7, 8],
      [0, 3, 6],
      [1, 4, 7],
      [2, 5, 8],
      [0, 4, 8],
      [2, 4, 6],
    ];

    for (var pattern in winPatterns) {
      final a = board[pattern[0]];
      final b = board[pattern[1]];
      final c = board[pattern[2]];
      if (a == b && b == c && a != '') return a;
    }

    if (board.every((element) => element != '')) {
      return 'Empate';
    }

    return '';
  }

  @override
  Widget build(BuildContext context) {
    final winner = _checkWinner();

    return Scaffold(
      appBar: AppBar(title: const Text('Jogo da Velha')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GridView.builder(
            shrinkWrap: true,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
            ),
            itemCount: 9,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: winner == '' ? () => _makeMove(index) : null,
                child: Container(
                  margin: const EdgeInsets.all(4),
                  color: Colors.blue[100],
                  child: Center(
                    child: Text(
                      board[index],
                      style: const TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
          if (winner != '') ...[
            const SizedBox(height: 20),
            Text(
              winner == 'Empate' ? 'Empate!' : '$winner venceu!',
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            ElevatedButton(
              onPressed: _resetGame,
              child: const Text('Reiniciar Jogo'),
            ),
          ],
        ],
      ),
    );
  }
}

