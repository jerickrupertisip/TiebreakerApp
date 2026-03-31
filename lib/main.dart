import "package:flutter/material.dart";
import "package:flutter_dotenv/flutter_dotenv.dart";
import "package:provider/provider.dart";
import "package:tiebreaker_app/services/decision_service.dart";
import "package:tiebreaker_app/screens/home_screen.dart";

Future<void> main() async {
  await dotenv.load(fileName: ".env");

  runApp(TieBreakerApp());
}

class TieBreakerApp extends StatefulWidget {
  const TieBreakerApp({super.key});

  @override
  State<TieBreakerApp> createState() => _TieBreakerAppState();
}

class _TieBreakerAppState extends State<TieBreakerApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => DecisionService())],
      child: MaterialApp(
        title: "Tie Breaker App",
        theme: ThemeData(
          colorSchemeSeed: Colors.deepPurple,
          brightness: Brightness.light,
        ),
        darkTheme: ThemeData(
          colorSchemeSeed: Colors.deepPurple,
          brightness: Brightness.dark,
        ),
        home: HomeScreen(),
      ),
    );
  }
}
