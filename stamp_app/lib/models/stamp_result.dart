class StampRecognition {
  final int stampIndex;
  final String? error;
  final Map<String, dynamic> data;

  StampRecognition({
    required this.stampIndex,
    this.error,
    required this.data,
  });

  factory StampRecognition.fromJson(Map<String, dynamic> json) {
    return StampRecognition(
      stampIndex: json['stamp'] ?? 0,
      error: json['error'],
      data: json['data'] ?? {},
    );
  }
}

class ImageUploadResult {
  final String status;
  final String? error;
  final List<StampRecognition> data;

  ImageUploadResult({
    required this.status,
    this.error,
    required this.data,
  });

  factory ImageUploadResult.fromJson(Map<String, dynamic> json) {
    var list = json['data'] as List? ?? [];
    List<StampRecognition> dataList = list.map((i) => StampRecognition.fromJson(i)).toList();

    return ImageUploadResult(
      status: json['status'] ?? 'failed',
      error: json['error'],
      data: dataList,
    );
  }
}
