import 'dart:io';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../providers/stamp_provider.dart';

class UploadScreen extends StatefulWidget {
  const UploadScreen({super.key});

  @override
  State<UploadScreen> createState() => _UploadScreenState();
}

class _UploadScreenState extends State<UploadScreen> {
  XFile? _selectedImage;
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _selectedImage = image;
      });
    }
  }

  Future<void> _upload() async {
    if (_selectedImage == null) return;

    final provider = Provider.of<StampProvider>(context, listen: false);
    
    dynamic fileData;
    if (kIsWeb) {
      fileData = await _selectedImage!.readAsBytes();
    } else {
      fileData = File(_selectedImage!.path);
    }

    await provider.uploadImages([
      MapEntry('file', fileData),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<StampProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Detect Stamps'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Center(
                child: _selectedImage == null
                    ? const Text('No image selected.')
                    : Semantics(
                        label: 'Selected document image',
                        child: kIsWeb
                            ? Image.network(_selectedImage!.path)
                            : Image.file(File(_selectedImage!.path)),
                      ),
              ),
            ),
            const SizedBox(height: 16),
            if (provider.isLoading)
              const Center(child: CircularProgressIndicator())
            else ...[
            Tooltip(
              message: 'Select a document image from your gallery',
              child: ElevatedButton.icon(
                onPressed: _pickImage,
                icon: const Icon(Icons.image),
                label: const Text('Select Image'),
              ),
            ),
              const SizedBox(height: 8),
              Tooltip(
                message: 'Upload selected image for stamp detection',
                child: ElevatedButton.icon(
                  onPressed: _selectedImage == null ? null : _upload,
                  icon: const Icon(Icons.cloud_upload),
                  label: const Text('Upload and Detect'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.primaryContainer,
                  ),
                ),
              ),
            ],
            const SizedBox(height: 16),
            if (provider.error != null)
              Text(
                'Error: ${provider.error}',
                style: const TextStyle(color: Colors.red),
              ),
            if (provider.uploadResults != null)
              Expanded(
                child: ListView.builder(
                  itemCount: provider.uploadResults!.length,
                  itemBuilder: (context, index) {
                    var entry = provider.uploadResults!.entries.elementAt(index);
                    var result = entry.value;
                    return Card(
                      child: ListTile(
                        title: Text('Result for ${entry.key}'),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Status: ${result.status}'),
                            if (result.error != null) Text('Error: ${result.error}'),
                            ...result.data.map((stamp) => Padding(
                                  padding: const EdgeInsets.only(top: 8.0),
                                  child: Text(
                                    'Stamp ${stamp.stampIndex}: ${stamp.error ?? 'Found - ${stamp.data['name'] ?? 'Unknown'}'}',
                                  ),
                                )),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }
}
