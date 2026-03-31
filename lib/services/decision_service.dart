import "package:flutter_dotenv/flutter_dotenv.dart";
import "package:google_generative_ai/google_generative_ai.dart";
import "package:tiebreaker_app/models/decision_result.dart";
import "package:flutter/foundation.dart";

class DecisionService extends ChangeNotifier {
  DecisionResult? currentResult;
  bool isLoading = false;
  String? errorMessage;

  final String _apiKey = dotenv.env["API_KEY"]!;

  Future<void> analyzeDecision(String decisionPrompt) async {
    isLoading = true;
    errorMessage = null;

    notifyListeners();

    try {
      final model = GenerativeModel(model: "gemini-2.5-flash", apiKey: _apiKey);
      final prompt =
          '''
You are an expert Decision-making assistant. The user is trying to make a decision "$decisionPrompt"
Please provide exactly 3 section of markdown(Each section must be Header 3 `### `):

1. ### Pros and Cons
Provide aq detailed pros and cons list

2. ### Comparison Table
If applicable, provide a comparison table comparing the main alternatives.

3. ### SWOT Analysis
Provide a SWOT (Strength, Weaknesses, Opportunities, Threats) Analysis for the decision.

Ensure the markdown is well-formated and easy to read. Do not Include extra text outside of the headers.
''';

      final content = [Content.text(prompt)];
      final response = await model.generateContent(content);
      debugPrint("Log:  ${response.text ?? "Nothing"}");
      currentResult = _parseResponse(response.text ?? "", decisionPrompt);
    } catch (e) {
      errorMessage = "Failed $e";
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  DecisionResult _parseResponse(String text, String decision) {
    final parts = text.split("###");
    return DecisionResult(
      decision: decision,
      prosAndCons: parts.length > 1 ? parts[1] : text,
      comparisonTable: parts.length > 2 ? parts[2] : "No Table",
      swotAnalysis: parts.length > 3 ? parts[3] : "No Table",
      rawContent: text,
    );
  }
}
