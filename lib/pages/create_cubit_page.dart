import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:saed_generator/utile.dart';

import '../const_data.dart';
import '../main.dart';

class AddCubitPage extends StatefulWidget {
  const AddCubitPage({super.key});

  @override
  State<AddCubitPage> createState() => _AddCubitPageState();
}

class _AddCubitPageState extends State<AddCubitPage> {
  final rootFolderController = TextEditingController();
  final nameServiceController = TextEditingController();
  final apiNameController = TextEditingController();
  CreateCubitType type = CreateCubitType.get;

  Future<void> _pickRootFolder() async {
    String? selectedDirectory = await FilePicker.platform.getDirectoryPath();
    if (selectedDirectory != null && selectedDirectory.isNotEmpty) {
      rootFolderController.text = selectedDirectory;
      setState(() {});
    }
  }

  Future<void> _createCubit() async {
    rootFolder = rootFolderController.text;
    nameService = nameServiceController.text;
    apiName = apiNameController.text;
    await createCubit(type: type);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('إضافة Cubit جديد')),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(minWidth: 500, maxWidth: 600),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 32),
              child: Card(
                elevation: 8,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                child: Padding(
                  padding: const EdgeInsets.all(32.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const Icon(Icons.add_box, size: 48, color: Colors.blue),
                      const SizedBox(height: 12),
                      Text(
                        'إضافة Cubit جديد',
                        style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 20),
                      ModernTextField(
                        controller: rootFolderController,
                        label: 'مسار الجذر',
                        icon: Icons.folder,
                        hint: 'مثال: C:/Users/Lenovo/StudioProjects/packages',
                        suffix: IconButton(
                          icon: const Icon(Icons.folder_open, color: Colors.blue),
                          tooltip: 'اختيار مجلد...',
                          onPressed: _pickRootFolder,
                        ),
                      ),
                      const SizedBox(height: 12),
                      ModernTextField(
                        controller: nameServiceController,
                        label: 'اسم الخدمة',
                        icon: Icons.miscellaneous_services,
                        hint: 'مثال: user',
                      ),
                      const SizedBox(height: 12),
                      ModernTextField(
                        controller: apiNameController,
                        label: 'اسم الـ API',
                        icon: Icons.api,
                        hint: 'مثال: user_api',
                      ),
                      const SizedBox(height: 12),
                      DropdownButtonFormField<CreateCubitType>(
                        decoration: InputDecoration(
                          labelText: 'نوع الخدمة',
                          prefixIcon: Icon(Icons.merge_type, color: Colors.blue),
                          hintText: 'نوع الخدمة',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          filled: true,
                          fillColor: Colors.blue.withOpacity(0.05),
                        ),
                        value: type,
                        items: CreateCubitType.values.map((CreateCubitType value) {
                          return DropdownMenuItem<CreateCubitType>(
                            value: value,
                            child: Text(value.name),
                          );
                        }).toList(),
                        onChanged: (CreateCubitType? newValue) {
                          if (newValue != null) {
                            setState(() {
                              type = newValue;
                            });
                          }
                        },
                      ),
                      const SizedBox(height: 20),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton.icon(
                          icon: const Icon(Icons.add),
                          label: const Padding(
                            padding: EdgeInsets.symmetric(vertical: 4.0),
                            child: Text('إنشاء الكيوبت', style: TextStyle(fontSize: 16)),
                          ),
                          style: ElevatedButton.styleFrom(
                            minimumSize: const Size(0, 40),
                            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          onPressed: _createCubit,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
