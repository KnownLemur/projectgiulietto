import 'package:flutter/material.dart';
import 'player_spot.dart';
import 'match_session.dart';

class LobbyScreen extends StatefulWidget {
  const LobbyScreen({super.key});

  @override
  State<LobbyScreen> createState() => _LobbyScreenState();
}

class _LobbyScreenState extends State<LobbyScreen> {
  int _playerCount = 5;
  int _turn = 1;
  int _initialLives =
      5; // Variabile per le vite iniziali (modificabile nelle impostazioni)
  String get _data => 'Turno: $_turn';
  List<String?> _playerNames = List.filled(8, null);
  List<int> _playerLives = List.filled(8, 5); // Vite dei giocatori
  final List<String> _frequentPlayers = [
    'Freddy',
    'Fra',
    'Anto',
    'Diego',
    'Phil',
    'Leo',
    'Lollo',
    'Richi',
    'Luca',
  ]; // Nomi frequenti per il menu rapido

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Lo Scaffold ora avvolge TUTTO. Niente più sottolineature!
      backgroundColor: Colors.brown[900],

      body: Stack(
        children: [
          // Rimosso il Container colorato di sfondo perché lo fa già lo Scaffold

          // Tavolo
          Center(
            child: FractionallySizedBox(
              widthFactor: 0.7,
              heightFactor: 0.6,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.green[800],
                  borderRadius: BorderRadius.circular(150),
                  border: Border.all(color: Colors.white, width: 4),
                ),
                child: Center(
                  child: Text(
                    _data,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ),

          // 2. IL BOTTONE IMPOSTAZIONI (Posizionato a mano)
          Positioned(
            top: 15, // Distanza dal bordo superiore
            right: 15, // Distanza dal bordo destro
            child: IconButton(
              icon: const Icon(Icons.settings, color: Colors.white70, size: 30),
              onPressed: () {
                _showSettings(); // Funzione per mostrare il menu delle impostazioni
              },
            ),
          ),

          // Dentro lo Stack di LobbyScreen...
          Positioned(
            bottom: 10,
            right: 15,
            child: SizedBox(
              width: 100,
              height: 40,
              child: FloatingActionButton.extended(
                backgroundColor: Colors.red[900],
                onPressed: () {
                  // 1. Prendiamo solo i nomi non nulli
                  List<String> activePlayers = _playerNames
                      .whereType<String>()
                      .toList();

                  if (activePlayers.length < 2) {
                    // Un piccolo avviso se mancano giocatori
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Inserisci almeno 2 giocatori!"),
                      ),
                    );
                    return;
                  }

                  // 2. Creiamo la sessione
                  MatchSession session = MatchSession(
                    playerNames: activePlayers,
                    initialLives:
                        _initialLives, // La variabile che imposterai nelle impostazioni
                  );

                  // 3. Procediamo alla fase di gioco (MatchScreen)
                  print("Partita Avviata!");
                  // Qui chiamerai una funzione passata dal main per cambiare stato
                },
                label: const Text(
                  "START",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                icon: const Icon(Icons.play_arrow, color: Colors.white),
              ),
            ),
          ),

          // Posti dei giocatori
          ...getPositions(_playerCount).asMap().entries.map((entry) {
            int idx = entry.key;
            Alignment pos = entry.value;

            return PlayerSpot(
              pos: pos,
              name: _playerNames[idx],
              lives: _playerLives[idx],
              onTap: () => _selectPlayer(idx),
            );
          }),
        ],
      ),
    );
  }

  void _selectPlayer(int index) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Posto ${index + 1}'),
        content: SizedBox(
          width: double.maxFinite,
          child: ListView(
            shrinkWrap: true, // Fondamentale per far stare il menu nel popup
            children: [
              ..._frequentPlayers.map(
                (name) => ListTile(
                  title: Text(name),
                  onTap: () {
                    setState(() => _playerNames[index] = name);
                    Navigator.pop(context);
                  },
                ),
              ),
              const Divider(),
              const ListTile(
                title: Text("Aggiungi nuovo..."),
                leading: Icon(Icons.add),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _updateGlobalLives(int newLives) {
    setState(() {
      _initialLives = newLives;
      // Aggiorniamo tutti i posti con il nuovo valore iniziale
      _playerLives = List.filled(8, newLives);
    });
  }

  void _updatePlayerCount(int newCount) {
    setState(() {
      _playerCount = newCount;
      //Resettiamo tutti i giocatori ogni volta che cambia il conteggio
      for (int i = 0; i < _playerNames.length; i++) {
        _playerNames[i] = null;
      }
    });
  }

  void _showSettings() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Impostazioni Partita"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text("Vite iniziali:"),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [3, 4, 5, 6]
                  .map(
                    (v) => ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: _initialLives == v
                            ? Colors.green
                            : null,
                      ),
                      onPressed: () {
                        _updateGlobalLives(
                          v,
                        ); // Chiamiamo la funzione di sincronizzazione
                        Navigator.pop(context);
                      },
                      child: Text("$v"),
                    ),
                  )
                  .toList(),
            ),
            const SizedBox(height: 20),
            const Text("Numero Giocatori:"),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [3, 4, 5, 6, 7, 8]
                  .map(
                    (v) => ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: _playerCount == v
                            ? Colors.green
                            : null,
                      ),
                      onPressed: () {
                        _updatePlayerCount(
                          v,
                        ); // Chiamiamo la funzione di sincronizzazione
                        Navigator.pop(context);
                      },
                      child: Text("$v"),
                    ),
                  )
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }
}

List<Alignment> getPositions(int count) {
  if (count == 3) {
    return [
      const Alignment(0, -0.8), // Centro alto
      const Alignment(-0.7, 0.6), // Sinistra basso
      const Alignment(0.7, 0.6), // Destra basso
    ];
  } else if (count == 4) {
    return [
      const Alignment(0, -0.8), // Capotavola
      const Alignment(-0.75, 0), // Sinistra
      const Alignment(0.75, 0), // Destra
      const Alignment(0, 0.8), // Sotto
    ];
  } else if (count == 5) {
    return [
      const Alignment(0, -0.8), // Capotavola
      const Alignment(-0.75, -0.2), // Sinistra alto
      const Alignment(0.75, -0.2), // Destra alto
      const Alignment(-0.4, 0.8), // Sinistra basso
      const Alignment(0.4, 0.8), // Destra basso
    ];
  } else if (count == 6) {
    return [
      const Alignment(0, -0.8), // Capotavola
      const Alignment(-0.7, -0.5), // Sinistra alto
      const Alignment(0.7, -0.5), // Destra alto
      const Alignment(-0.7, 0.5), // Sinistra basso
      const Alignment(0.7, 0.5), // Destra basso
      const Alignment(0, 0.8), // Sotto
    ];
  } else if (count == 7) {
    return [
      const Alignment(0, -0.8), // Capotavola
      const Alignment(-0.6, -0.75), // Sinistra alto
      const Alignment(0.6, -0.75), // Destra alto
      const Alignment(-0.75, 0.3), // Sinistra basso
      const Alignment(0.75, 0.3), // Destra basso
      const Alignment(-0.3, 0.8), // Sinistra basso
      const Alignment(0.3, 0.8), // Destra sotto
    ];
  } else if (count == 8) {
    return [
      const Alignment(0, -0.8), // Capotavola
      const Alignment(-0.5, -0.75), // Sinistra alto
      const Alignment(0.5, -0.75), // Destra alto
      const Alignment(-0.75, 0), // Sinistra basso
      const Alignment(0.75, 0), // Destra basso
      const Alignment(-0.5, 0.75), // Sinistra sotto
      const Alignment(0.5, 0.75), // Destra sotto
      const Alignment(0, 0.8), // Sotto centrale
    ];
  } else {
    throw ArgumentError('Unsupported player count: $count');
  }
}
