# Help & Documentation - Flutter Postage Stamp Recognition App

This document provides guidance on how to use and maintain the Flutter application.

## 1. Getting Started
To run the app on your machine:
1.  **Prerequisites**: Install [Flutter SDK](https://docs.flutter.dev/get-started/install).
2.  **Setup**: Navigate to the `stamp_app` directory.
3.  **Run**: Execute `flutter run` and select your target (Chrome, Windows, or Android).

## 2. Core Features
### Detect Stamps
- Use this feature to upload a document image (JPG/PNG).
- The app communicates with the Python Flask backend to identify all stamps in the image.
- Results show the stamp location (index) and the best match from the database with an accuracy percentage.

### Add New Stamp
- Use this to expand your database.
- Provide a unique name and an image of the stamp.
- The system extracts feature embeddings and saves them for future identification.

### History
- View a session-based log of all recent detection attempts.
- Tap a history item to expand and see the specific stamps identified in that scan.

## 3. Accessibility
The app is built with accessibility in mind:
- **Screen Readers**: All buttons and images have semantic labels for TalkBack, VoiceOver, and NVDA.
- **High Contrast**: The UI uses Material 3 Color Schemes which are designed for readability.
- **Keyboard Navigation**: Fully supports `Tab` and `Enter` keys for users who cannot use a mouse or touchscreen.
- **Responsive Text**: Text sizes adjust according to system settings.

## 4. Backend Configuration
The app connects to the API via `lib/services/api_service.dart`. 
- **Default URL**: `http://127.0.0.1:5000`
- **Android Emulator**: Change to `http://10.0.2.2:5000` if testing on a local emulator.
