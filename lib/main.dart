import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Tic Tac Toe',
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<String> boxText = ["", "", "", "", "", "", "", "", ""];
  int counter = 0;
  int playerXWins = 0;
  int playerOWins = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[800],
      body: Padding(
        padding: const EdgeInsets.only(bottom: 150),
        child: Column(
          children: [
            const SizedBox(
              height: 50,
            ),
            Expanded(
              child: GridView.builder(
                  itemCount: 9,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3),
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: () => onTap(index),
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: const Color.fromRGBO(97, 97, 97, 1))),
                        child: Center(
                          child: Text(
                            boxText[index],
                            style: const TextStyle(
                                color: Colors.white, fontSize: 40),
                          ),
                        ),
                      ),
                    );
                  }),
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  'Player X',
                  style: const TextStyle(color: Colors.white, fontSize: 28),
                ),
                Text(
                  'Player O',
                  style: const TextStyle(color: Colors.white, fontSize: 28),
                )
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  '$playerXWins Wins',
                  style: const TextStyle(color: Colors.white, fontSize: 26),
                ),
                Text(
                  '$playerOWins Wins',
                  style: const TextStyle(color: Colors.white, fontSize: 26),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  void onTap(int index) {
    int result = -1;
    if (counter <= 7) {
      if (counter % 2 == 0) {
        setState(() {
          boxText[index] = 'X';
        });
      } else {
        setState(() {
          boxText[index] = 'O';
        });
      }
      result = calculateWinner();
      if (result == 1) {
        showDialogBox(context, "X Wins");
        playerXWins++;
      } else if (result == 0) {
        showDialogBox(context, "O Wins");
        playerOWins++;
      }
    } else {
      result = calculateWinner();
      if (result == 2) {
        showDialogBox(context, "Game Drawn");
      }
    }

    counter++;
  }

  int calculateWinner() {
    String result = '';
    // Define all winning combinations
    List<List<int>> winningCombinations = [
      [0, 1, 2], [3, 4, 5], [6, 7, 8], // Rows
      [0, 3, 6], [1, 4, 7], [2, 5, 8], // Columns
      [0, 4, 8], [2, 4, 6], // Diagonals
    ];

    // Check each winning combination
    for (var combination in winningCombinations) {
      var mark = boxText[combination[0]];
      if (mark.isNotEmpty &&
          mark == boxText[combination[1]] &&
          mark == boxText[combination[2]]) {
        result = "$mark Wins"; // Return the winning mark (X or O)
      }
    }
    if (result == "X Wins") {
      return 1;
    } else if (result == "O Wins") {
      return 0;
    }
    return 2; // Return empty string if there is no winner
  }

  void showDialogBox(BuildContext context, String msg) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(msg),
          content: const Text("Would you like to play again?"),
          actions: [
            TextButton(
              onPressed: () {
                setState(() {
                  boxText = List.filled(9, '');
                  counter = 0;
                });
                Navigator.of(context).pop();
              },
              child: Text('Play Again'),
            ),
          ],
        );
      },
    );
  }
}
