import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stamp_app/providers/stamp_provider.dart';
import 'package:stamp_app/screens/home_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => StampProvider()),
      ],
      child: const StampApp(),
    ),
  );
}

class StampApp extends StatelessWidget {
  const StampApp({super.key});

  @override
  Widget build(BuildContext context) {
    const textTheme = TextTheme(
      displayLarge: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
      bodyLarge: TextStyle(fontSize: 18),
      bodyMedium: TextStyle(fontSize: 16),
      titleLarge: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
    );

    return MaterialApp(
      title: 'Flutter Postage Stamp Recognition App',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
          brightness: Brightness.light,
        ),
        textTheme: textTheme,
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
          brightness: Brightness.dark,
        ),
        textTheme: textTheme,
      ),
      home: const HomeScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
