import "package:flutter/material.dart";
import "package:flutter_markdown_plus/flutter_markdown_plus.dart";
import "package:provider/provider.dart";
import "package:tiebreaker_app/services/decision_service.dart";

class ResultsScreen extends StatelessWidget {
  const ResultsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final result = Provider.of<DecisionService>(context).currentResult;
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Analyze Results"),
          bottom: TabBar(
            tabs: [
              Tab(text: "Pros/Cons"),
              Tab(text: "Comparison"),
              Tab(text: "SWOT"),
              Tab(text: "Raw Content"),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            Markdown(data: result!.prosAndCons),
            Markdown(data: result.comparisonTable),
            Markdown(data: result.swotAnalysis),
            Markdown(data: result.rawContent),
          ],
        ),
      ),
    );
  }
}
