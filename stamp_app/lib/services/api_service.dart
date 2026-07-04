import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import '../models/stamp_result.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class ApiService {
  // Use 10.0.2.2 for Android emulator to access localhost, 
  // or localhost for web/windows.
  static const String baseUrl = 'http://127.0.0.1:5000';

  Future<Map<String, ImageUploadResult>> uploadImages(List<MapEntry<String, dynamic>> files) async {
    var request = http.MultipartRequest('POST', Uri.parse('$baseUrl/images/upload'));
    
    for (var entry in files) {
      if (kIsWeb) {
         request.files.add(http.MultipartFile.fromBytes(
          entry.key,
          entry.value as List<int>,
          filename: 'upload.png', // Default filename
          contentType: MediaType('image', 'png'),
        ));
      } else {
        request.files.add(await http.MultipartFile.fromPath(
          entry.key,
          (entry.value as File).path,
        ));
      }
    }

    var streamedResponse = await request.send();
    var response = await http.Response.fromStream(streamedResponse);

    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      Map<String, ImageUploadResult> results = {};
      jsonResponse['data'].forEach((key, value) {
        results[key] = ImageUploadResult.fromJson(value);
      });
      return results;
    } else {
      throw Exception('Failed to upload images');
    }
  }

  Future<Map<String, dynamic>> addStamp(String name, dynamic file) async {
    var request = http.MultipartRequest('POST', Uri.parse('$baseUrl/images/add_stamp'));
    
    request.fields['${name}_stamp_group_name'] = name;
    
    if (kIsWeb) {
      request.files.add(http.MultipartFile.fromBytes(
        name,
        file as List<int>,
        filename: '$name.png',
        contentType: MediaType('image', 'png'),
      ));
    } else {
      request.files.add(await http.MultipartFile.fromPath(
        name,
        (file as File).path,
      ));
    }

    var streamedResponse = await request.send();
    var response = await http.Response.fromStream(streamedResponse);

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to add stamp');
    }
  }
}
