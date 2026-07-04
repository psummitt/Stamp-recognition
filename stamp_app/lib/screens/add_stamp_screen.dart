import 'dart:io';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../providers/stamp_provider.dart';

class AddStampScreen extends StatefulWidget {
  const AddStampScreen({super.key});

  @override
  State<AddStampScreen> createState() => _AddStampScreenState();
}

class _AddStampScreenState extends State<AddStampScreen> {
  final TextEditingController _nameController = TextEditingController();
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

  Future<void> _submit() async {
    if (_selectedImage == null || _nameController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please provide a name and an image')),
      );
      return;
    }

    final provider = Provider.of<StampProvider>(context, listen: false);
    
    dynamic fileData;
    if (kIsWeb) {
      fileData = await _selectedImage!.readAsBytes();
    } else {
      fileData = File(_selectedImage!.path);
    }

    bool success = await provider.addStamp(_nameController.text, fileData);

    if (success && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Stamp added successfully!')),
      );
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<StampProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Add New Stamp'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Semantics(
              label: 'Enter stamp name',
              child: TextField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Stamp Name',
                  border: OutlineInputBorder(),
                  hintText: 'e.g., Company Seal',
                ),
              ),
            ),
            const SizedBox(height: 20),
            Center(
              child: _selectedImage == null
                  ? const Text('No image selected.')
                  : Semantics(
                      label: 'Selected stamp image',
                      child: Container(
                        height: 200,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                        ),
                        child: kIsWeb
                            ? Image.network(_selectedImage!.path)
                            : Image.file(File(_selectedImage!.path)),
                      ),
                    ),
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: _pickImage,
              icon: const Icon(Icons.image),
              label: const Text('Select Stamp Image'),
            ),
            const SizedBox(height: 32),
            if (provider.isLoading)
              const Center(child: CircularProgressIndicator())
            else
              ElevatedButton(
                onPressed: _submit,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  foregroundColor: Theme.of(context).colorScheme.onPrimary,
                ),
                child: const Text('Add to Database', style: TextStyle(fontSize: 18)),
              ),
            if (provider.error != null)
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: Text(
                  'Error: ${provider.error}',
                  style: const TextStyle(color: Colors.red),
                  textAlign: TextAlign.center,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
