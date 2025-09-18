import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

import '../const_data.dart';
import '../main.dart';
import '../utile.dart';

class FullService extends StatefulWidget {
  const FullService({super.key});

  @override
  State<FullService> createState() => _FullServiceState();
}

class _FullServiceState extends State<FullService> {
  final rootFolderController = TextEditingController();
  final nameServiceController = TextEditingController();
  final apiNameController = TextEditingController();

  Future<void> _pickRootFolder() async {
    String? selectedDirectory = await FilePicker.platform.getDirectoryPath();
    if (selectedDirectory != null && selectedDirectory.isNotEmpty) {
      rootFolderController.text = selectedDirectory;
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Full Service'),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 32),
            child: Card(
              elevation: 8,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Icon(Icons.auto_awesome, size: 60, color: Colors.blue),
                    const SizedBox(height: 16),
                    Text(
                      'إنشاء خدمة كاملة',
                      style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 24),
                    ModernTextField(
                      controller: rootFolderController,
                      label: 'اسم مجلد الجذر',
                      icon: Icons.folder,
                      hint: 'مثال: packages/my_project',
                      suffix: IconButton(
                        icon: const Icon(Icons.folder_open, color: Colors.blue),
                        tooltip: 'اختيار مجلد...',
                        onPressed: _pickRootFolder,
                      ),
                    ),
                    const SizedBox(height: 16),
                    ModernTextField(
                      controller: nameServiceController,
                      label: 'اسم الخدمة',
                      icon: Icons.miscellaneous_services,
                      hint: 'مثال: user',
                    ),
                    const SizedBox(height: 16),
                    ModernTextField(
                      controller: apiNameController,
                      label: 'اسم الـ API',
                      icon: Icons.api,
                      hint: 'مثال: user_api',
                    ),
                    const SizedBox(height: 32),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        icon: const Icon(Icons.create_new_folder),
                        label: const Padding(
                          padding: EdgeInsets.symmetric(vertical: 8.0),
                          child: Text('إنشاء المجلدات والملفات'),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          textStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                        onPressed: () {
                          rootFolder = rootFolderController.text;
                          nameService = nameServiceController.text;
                          apiName = apiNameController.text;
                          createFullService();
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
