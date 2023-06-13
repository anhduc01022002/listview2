import 'package:flutter/material.dart';
import 'package:listview2/game_logic.dart';

void main() => runApp(const HomePage());

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  final Game _game = Game();
  List<int> selectedImg = [];

  @override
  void initState() {
    super.initState();
    _game.initGame();
  }

  void resetGame() {
    setState(() {
      _game.initGame();
      selectedImg.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Cards"),
        ),
        body: Column(
          children: [
            Expanded(
              child: SizedBox(
                width: screenWidth,
                child: GridView.builder(
                  itemCount: _game.gameImg!.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10.0,
                    mainAxisSpacing: 10.0,
                    childAspectRatio: 1.0,
                  ),
                  padding: const EdgeInsets.all(16.0),
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        if (selectedImg.length < 2) {
                          setState(() {
                            selectedImg.add(index);
                            _game.flipCard(index);
                          });
                          if (selectedImg.length == 2) {
                            Future.delayed(const Duration(seconds: 1), () {
                              _game.checkMatch(selectedImg[0], selectedImg[1]);
                              selectedImg.clear();
                              setState(() {});
                            });
                          }
                        }
                      },
                      child: Container(
                        padding: const EdgeInsets.all(16.0),
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(8.0),
                          image: DecorationImage(
                            image: AssetImage(_game.gameImg![index]),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(50),  // creates a space of 5 pixels
              child: _game.isGameOver() ?
              SizedBox(
                width: double.infinity,  // makes the button as wide as its parent allows
                child: TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.blue,
                    padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),  // increase the size of the button
                  ),
                  onPressed: resetGame,
                  child: const Text(
                    'Reset',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,  // increase the font size
                    ),
                  ),
                ),
              ) : const SizedBox.shrink(),  // if game is not over, render an empty box
            ),
          ],
        ),
      ),
    );
  }
}