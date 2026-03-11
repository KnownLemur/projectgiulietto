class MatchSession {
  final List<String> playerNames;
  final int initialLives;
  int currentTurn = 1;
  late int currentCards;

  // Strutture per il file di testo
  List<String> liveLog = []; // Per il "Resoconto Live"
  Map<String, List<int>> livesHistory = {}; // Per il "Riassunto"

  MatchSession({required this.playerNames, required this.initialLives}) {
    // Regola PRO: se i giocatori sono 7 o 8, si parte da 5 carte
    currentCards = playerNames.length >= 7 ? 5 : 6;

    // Inizializziamo la storia delle vite per ogni giocatore
    for (var name in playerNames) {
      livesHistory[name] = [initialLives];
    }
  }

  void recordTurn({required Map<String, int> losses, String comment = ""}) {
    String turnDetails = "Turno $currentTurn; $currentCards carte; ";
    String lostBy = "Vite perse da: ";

    losses.forEach((name, amount) {
      if (amount > 0) {
        lostBy += "$name (-$amount) ";
        // Aggiorniamo la storia delle vite (ultimo valore - perdita)
        int lastLife = livesHistory[name]!.last;
        livesHistory[name]!.add(lastLife - amount);
      } else {
        // Se non perde vite, mantiene il valore precedente per la tabella
        livesHistory[name]!.add(livesHistory[name]!.last);
      }
    });

    liveLog.add("$turnDetails $lostBy; Commenti: $comment");

    // Logica rotazione carte (6->1 e poi ricomincia)
    if (currentCards > 1) {
      currentCards--;
    } else {
      currentCards = playerNames.length >= 7 ? 5 : 6;
    }
    currentTurn++;
  }
}
