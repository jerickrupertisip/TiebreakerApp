import "package:flutter/material.dart";
import "package:tiebreaker_app/screens/processing_screen.dart";

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Tiebreaker App")),
      body: Padding(
        padding: EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: .center,
          children: [
            TextField(
              controller: _controller,
              decoration: InputDecoration(
                labelText: "What decision are you making?",
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                if (_controller.text.isNotEmpty) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) =>
                          ProcessingScreen(decision: _controller.text),
                    ),
                  );
                }
              },
              child: Text("Help me decide"),
            ),
          ],
        ),
      ),
    );
  }
}
