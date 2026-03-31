import "package:flutter/material.dart";
import "package:provider/provider.dart";
import "package:tiebreaker_app/screens/results_screen.dart";
import "package:tiebreaker_app/services/decision_service.dart";

class ProcessingScreen extends StatefulWidget {
  final String decision;

  const ProcessingScreen({super.key, required this.decision});

  @override
  State<ProcessingScreen> createState() => _ProcessingScreenState();
}

class _ProcessingScreenState extends State<ProcessingScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final ds = Provider.of<DecisionService>(context, listen: false);

      await ds.analyzeDecision(widget.decision);

      if (mounted && ds.errorMessage == null) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => ResultsScreen()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: CircularProgressIndicator()));
  }
}
