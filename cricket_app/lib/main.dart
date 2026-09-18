import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(const MiniCricketApp());
}

class MiniCricketApp extends StatelessWidget {
  const MiniCricketApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Mini Cricket',
      home: const CricketGame(),
    );
  }
}

class CricketGame extends StatefulWidget {
  const CricketGame({super.key});

  @override
  State<CricketGame> createState() => _CricketGameState();
}

class _CricketGameState extends State<CricketGame> {
  // --- State Variables ---
  int balls = 6;         // Initially you have 6 balls
  int totalRuns = 0;     // Total score
  String currentRunText = ""; // Text to show "3 runs", "no runs", etc.

  // --- Logic Functions ---
  void playBall() {
    setState(() {
      // Generate a random number between 0 and 6 (nextInt(7) means 0 to 6)
      int runs = Random().nextInt(7); 
      
      totalRuns += runs; // Append runs
      balls--;           // Reduce one ball
      
      // Update the text based on the runs scored
      if (runs == 0) {
        currentRunText = "No Runs";
      } else {
        currentRunText = "$runs Runs";
      }
    });
  }

  void restartGame() {
    setState(() {
      // Reset everything back to initial state
      balls = 6;
      totalRuns = 0;
      currentRunText = "";
    });
  }

  // --- UI Structure ---
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[600], // Match the blue background from the screenshots
      appBar: AppBar(
        title: const Text('Mini Cricket', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.blue[900],
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Following the Row( Column, Column ) structure from the whiteboard
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // --- Left Column: Bat & Runs ---
                Column(
                  children: [
                    // Image Box (I1)
                    Container(
                      width: 100,
                      height: 100,
                      color: Colors.white,
                      // NOTE: Replace this Icon with your actual image: Image.asset('assets/bat.png')
                      child: const Icon(Icons.sports_cricket, size: 80, color: Colors.brown), 
                    ),
                    const SizedBox(height: 10),
                    // Text Box (T1)
                    const Text('Runs', style: TextStyle(color: Colors.white, fontSize: 18)),
                    // Value Box (v1)
                    Text('$totalRuns', style: const TextStyle(color: Colors.white, fontSize: 36, fontWeight: FontWeight.bold)),
                  ],
                ),
                
                // --- Right Column: Ball & Balls remaining ---
                Column(
                  children: [
                    // Image Box (I2)
                    Container(
                      width: 100,
                      height: 100,
                      color: Colors.white,
                      // NOTE: Replace this Icon with your actual image: Image.asset('assets/ball.png')
                      child: const Icon(Icons.sports_baseball, size: 80, color: Colors.red), 
                    ),
                    const SizedBox(height: 10),
                    // Text Box (T2)
                    const Text('Balls', style: TextStyle(color: Colors.white, fontSize: 18)),
                    // Value Box (v2)
                    Text('$balls', style: const TextStyle(color: Colors.white, fontSize: 36, fontWeight: FontWeight.bold)),
                  ],
                ),
              ],
            ),
            
            const SizedBox(height: 40),
            
            // Result Text showing runs for the current ball
            Text(
              currentRunText,
              style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
            ),
            
            const SizedBox(height: 20),
            
            // The Button (changes depending on if balls > 0)
            ElevatedButton(
              // If balls > 0, button plays ball. If 0, it restarts.
              onPressed: balls > 0 ? playBall : restartGame, 
              style: ElevatedButton.styleFrom(
                backgroundColor: balls > 0 ? Colors.blue[800] : Colors.red, // Blue for Bat, Red for Restart
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
              ),
              child: Text(
                balls > 0 ? 'Bat' : 'Restart',
                style: const TextStyle(fontSize: 18, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
