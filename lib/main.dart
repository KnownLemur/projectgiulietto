import 'package:flutter/material.dart';
import 'title_screen.dart';
import 'lobby_screen.dart';

void main() {
  runApp(MaterialApp(home: MainWindow()));
}

class MainWindow extends StatefulWidget {
  const MainWindow({super.key});

  @override
  State<MainWindow> createState() => _MainWindowState();
}

class _MainWindowState extends State<MainWindow> {
  bool showLobby = false;

  @override
  Widget build(BuildContext context) {
    if (showLobby) {
      return LobbyScreen();
    } else {
      return TitleScreen(
        onTouch: () {
          setState(() {
            showLobby = true;
          });
        },
      );
    }
  }
}
/*
  Widget buildTitle() {
    return GestureDetector(
      onTap: () {
        setState(() {
          showLobby = true;
        });
      },
      child: Text(
        'ProjectGiulietto',
        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget buildLobby() {
    return Container(
      color: Colors.brown[900],
      child: FractionallySizedBox(
        widthFactor: 0.7,
        heightFactor: 0.7,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.green[800],
            borderRadius: BorderRadius.circular(100),
          ),
        ),
      ),
    );
  }
}
MaterialApp(
      home: Scaffold(
        body: Center(
          child: GestureDetector(
            onTap: () {
              print('Text tapped!');
            },
            child: Text(
              'Hello Giulietto!',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    ),
  );
*/