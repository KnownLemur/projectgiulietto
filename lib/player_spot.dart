import 'package:flutter/material.dart';

class PlayerSpot extends StatelessWidget {
  final Alignment pos;
  final String? name;
  final int lives; // <--- Nuova variabile per le vite
  final VoidCallback? onTap;

  const PlayerSpot({
    super.key,
    required this.pos,
    this.name,
    this.lives = 5, // Default a 5
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: pos,
      child: Stack(
        clipBehavior:
            Clip.none, // Permette al cerchietto rosso di "uscire" dal bordo
        children: [
          // CERCHIO PRINCIPALE (Giocatore)
          GestureDetector(
            onTap: onTap,
            child: Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: Colors.grey[900], // Un po' più scuro per contrasto
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white70, width: 2),
                boxShadow: const [
                  BoxShadow(blurRadius: 10, color: Colors.black45),
                ],
              ),
              child: Center(
                child: name == null
                    ? const Icon(Icons.add, color: Colors.white54)
                    : Text(
                        name!,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
              ),
            ),
          ),

          // CERCHIETTO DELLE VITE (Appendice)
          // Appare solo se un giocatore è assegnato
          if (name != null)
            Positioned(
              bottom: 0,
              left: 0,
              child: Container(
                width: 28,
                height: 28,
                decoration: BoxDecoration(
                  color: Colors.red[700],
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 2),
                ),
                child: Center(
                  child: Text(
                    '$lives',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
