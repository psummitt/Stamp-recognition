import 'package:flutter/material.dart';
import '../models/stamp_result.dart';
import '../services/api_service.dart';

class StampProvider with ChangeNotifier {
  final ApiService _apiService = ApiService();
  
  Map<String, ImageUploadResult>? _uploadResults;
  Map<String, ImageUploadResult>? get uploadResults => _uploadResults;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _error;
  String? get error => _error;

  Future<void> uploadImages(List<MapEntry<String, dynamic>> files) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _uploadResults = await _apiService.uploadImages(files);
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> addStamp(String name, dynamic file) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      await _apiService.addStamp(name, file);
      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _error = e.toString();
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }
}
