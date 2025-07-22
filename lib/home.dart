import 'package:flutter/material.dart';
import 'easy.dart';
import 'hard.dart';
import 'players.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
} 

class _HomeState extends State<Home> {
  final TextEditingController _controllerPlayerX = TextEditingController();
  final TextEditingController _controllerPlayerO = TextEditingController();

  @override
  void dispose() {
    _controllerPlayerX.dispose();
    _controllerPlayerO.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.cyanAccent,
      appBar: AppBar(
        toolbarHeight: 80.0,
        title: const Text(
          'X O GAME',
          style: TextStyle(
              color: Colors.cyanAccent,
              fontWeight: FontWeight.bold,
              fontSize: 45.0),
        ),
        centerTitle: true,
        backgroundColor: Colors.black,
      ),
      body: Center(
        child: Column(
          children: [
            const SizedBox(
              height: 70.0,
            ),
            const Text('Enter Player\'s X name:', style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),),
            const SizedBox(
              height: 20.0,
            ),
            SizedBox(
              width: 250,
              height: 50,
              child: TextField(
                  controller: _controllerPlayerX,
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Enter player X name')),
            ),
            const SizedBox(
              height: 20.0,
            ),
            const Text('Enter Player\'s O name:', style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),),
            const SizedBox(
              height: 30.0,
            ),
            SizedBox(
              width: 250,
              height: 50,
              child: TextField(
                  controller: _controllerPlayerO,
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Enter player O name')),
            ),
            const SizedBox(
              height: 70.0,
            ),
            const Text(
              'Choose your level:',
              style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 30.0,
            ),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  foregroundColor: Colors.cyanAccent,
                ),
                onPressed: () {
                  openEasyPage();
                },
                child: const Text(
                  'EASY',
                  style: TextStyle(fontSize: 25.0),
                )),
            const SizedBox(
              height: 30.0,
            ),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  foregroundColor: Colors.cyanAccent,
                ),
                onPressed: () {
                  openHardPage();
                },
                child: const Text(
                  'HARD',
                  style: TextStyle(fontSize: 25.0),
                )),
          ],
        ),
      ),
    );
  }

  void openEasyPage() {
    try{
      String playerX = _controllerPlayerX.text;
      String playerO = _controllerPlayerO.text;
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => const Easy(),
          settings: RouteSettings(arguments: Players(playerX, playerO))));
    }catch(e){
      const Text('Enter players names', style: TextStyle(fontSize: 20.0),);
    }
  }

  void openHardPage() {
    try{
      String playerX = _controllerPlayerX.text;
      String playerO = _controllerPlayerO.text;
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => const Hard(),
          settings: RouteSettings(arguments: Players(playerX, playerO))));
    }catch(e){
      const Text('Enter players names', style: TextStyle(fontSize: 20.0),);
    }
  }
}
