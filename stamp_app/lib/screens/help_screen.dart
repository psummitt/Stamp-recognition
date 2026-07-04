import 'package:flutter/material.dart';

class HelpScreen extends StatelessWidget {
  const HelpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Help & Instructions'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(24.0),
        children: [
          _buildHelpSection(
            context,
            'How to Detect Stamps',
            '1. Go to "Detect Stamps" from the home screen.\n'
            '2. Tap "Select Image" to pick a document scan (JPG/PNG).\n'
            '3. Tap "Upload and Detect".\n'
            '4. The app will show identified stamps and their matching names from the database.',
          ),
          const Divider(),
          _buildHelpSection(
            context,
            'How to Add a New Stamp',
            '1. Go to "Add New Stamp".\n'
            '2. Enter a unique name for the stamp.\n'
            '3. Select an image of the stamp.\n'
            '4. Tap "Add to Database". The system will extract features and save them.',
          ),
          const Divider(),
          _buildHelpSection(
            context,
            'Accessibility Features',
            '• Screen reader support (TalkBack/VoiceOver).\n'
            '• High contrast color scheme.\n'
            '• Keyboard navigation for Web and Windows.\n'
            '• Large, readable text.',
          ),
        ],
      ),
    );
  }

  Widget _buildHelpSection(BuildContext context, String title, String content) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 8),
          Text(
            content,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ],
      ),
    );
  }
}
