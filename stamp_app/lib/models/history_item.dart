import 'stamp_result.dart';

class HistoryItem {
  final DateTime timestamp;
  final String fileName;
  final ImageUploadResult result;

  HistoryItem({
    required this.timestamp,
    required this.fileName,
    required this.result,
  });
}
