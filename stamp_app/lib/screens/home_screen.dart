import 'package:flutter/material.dart';
import 'upload_screen.dart';
import 'add_stamp_screen.dart';
import 'help_screen.dart';
import 'history_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Postage Stamp Recognition App'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.history),
            tooltip: 'View Detection History',
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const HistoryScreen()),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.help_outline),
            tooltip: 'App Help and Instructions',
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const HelpScreen()),
            ),
          ),
        ],
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Semantics(
                label: 'App Logo showing a stamp scanner icon',
                image: true,
                child: const Icon(Icons.qr_code_scanner, size: 100, color: Colors.blue),
              ),
              const SizedBox(height: 32),
              Semantics(
                header: true,
                child: Text(
                  'Welcome to Flutter Postage Stamp Recognition App',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.displayLarge,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'Detect, classify, and compare stamps in document scans.',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const SizedBox(height: 48),
              _buildNavButton(
                context,
                'Detect Stamps',
                'Upload a document to find and identify stamps.',
                Icons.search,
                const UploadScreen(),
                'Find stamps in your images',
              ),
              const SizedBox(height: 16),
              _buildNavButton(
                context,
                'Add New Stamp',
                'Register a new stamp in the database.',
                Icons.add_a_photo,
                const AddStampScreen(),
                'Register a new stamp template',
              ),
              const SizedBox(height: 16),
              _buildNavButton(
                context,
                'View History',
                'See your previous detection results.',
                Icons.history,
                const HistoryScreen(),
                'Open history of detected stamps',
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavButton(
    BuildContext context,
    String title,
    String subtitle,
    IconData icon,
    Widget screen,
    String accessibilityHint,
  ) {
    return Semantics(
      button: true,
      label: title,
      value: subtitle,
      hint: accessibilityHint,
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: InkWell(
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => screen),
          ),
          borderRadius: BorderRadius.circular(12),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              children: [
                ExcludeSemantics(
                  child: Icon(icon, size: 40, color: Theme.of(context).colorScheme.primary),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(title, style: Theme.of(context).textTheme.titleLarge),
                      Text(subtitle, style: Theme.of(context).textTheme.bodyMedium),
                    ],
                  ),
                ),
                const ExcludeSemantics(
                  child: Icon(Icons.arrow_forward_ios),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
