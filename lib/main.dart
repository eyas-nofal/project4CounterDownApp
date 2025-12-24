import 'dart:async';

import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

// Main counter down widget
class CounterDown extends StatefulWidget {
  const CounterDown({super.key});

  @override
  State<CounterDown> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<CounterDown> {
  int counterNumber = 10; // Initial countdown number
  Timer? globTimer; // Timer object to manage periodic countdown

  // Function to start the countdown timer
  changeSeconds() {
    // Prevent multiple timers from starting at the same time
    if (globTimer != null && globTimer!.isActive) return;

    // Start a periodic timer that decrements the counter every second
    globTimer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (counterNumber > 0) {
          counterNumber--;
        } else {
          globTimer?.cancel(); // Stop timer when it reaches 0
        }
      });
    });
  }

  @override
  void dispose() {
    globTimer?.cancel(); // Cancel timer when widget is disposed
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Counter Down App"),
        backgroundColor: const Color.fromARGB(255, 60, 67, 69),
        shadowColor: Colors.black,
        elevation: 2,
      ),
      backgroundColor: const Color.fromARGB(255, 55, 59, 60),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Display countdown number
          Text(
            counterNumber.toString().padLeft(2, "0"),
            style: const TextStyle(fontSize: 80, color: Colors.white),
          ),
          const SizedBox(height: 10),
          const Text(
            "Seconds",
            style: TextStyle(fontSize: 25, color: Colors.white),
          ),
          const SizedBox(height: 25),

          // Buttons for Start, Stop, Reset
        Center(
  child: Wrap(
    alignment: WrapAlignment.center, // Center horizontally
    runAlignment: WrapAlignment.center, // Center vertically between lines
    spacing: 25, // Horizontal space
    runSpacing: 15, // Vertical space
    children: [
      // Start Timer Button (Blue)
      SizedBox(
        height: 45,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue,
            foregroundColor: Colors.white, // White text
          ),
          onPressed: changeSeconds,
          child: const Text("Start Timer"),
        ),
      ),
      // Stop Timer Button (Red)
      SizedBox(
        height: 45,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red,
            foregroundColor: Colors.white, // White text
          ),
          onPressed: () {
            globTimer?.cancel();
          },
          child: const Text("Stop Timer"),
        ),
      ),
      // Reset Timer Button (Grey)
      SizedBox(
        height: 45,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.grey,
            foregroundColor: Colors.white, // White text
          ),
          onPressed: () {
            globTimer?.cancel();
            setState(() => counterNumber = 10); // Reset counter
          },
          child: const Text("Reset"),
        ),
      ),
    ],
  ),
),
        ],
      ),
    );
  }
}

// Main app entry point
class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CounterDown(),
    );
  }
}
