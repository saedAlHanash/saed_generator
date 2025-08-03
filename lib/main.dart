import 'package:flutter/material.dart';
import 'package:saed_generator/utile.dart';

import '../const_data.dart';
import 'package:file_picker/file_picker.dart';
import 'blocs/add_cubit_g.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Saed Generator',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
          elevation: 2,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            textStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
          ),
        ),
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final cardItems = [
      _HomeCardData(
        title: 'Full Service',
        icon: Icons.auto_awesome,
        description: 'إنشاء خدمة كاملة تلقائيًا مع جميع الملفات.',
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const FullService()),
        ),
      ),
      _HomeCardData(
        title: 'Add Cubit',
        icon: Icons.add_box,
        description: 'إضافة Cubit جديد لمشروعك بسهولة.',
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const AddCubitPage()),
        ),
      ),
      _HomeCardData(
        title: 'Add Service Cubit',
        icon: Icons.add_business,
        description: 'إضافة Service Cubit جديد.',
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const AddServiceCubitPage()),
        ),
      ),
      _HomeCardData(
        title: 'Page',
        icon: Icons.hourglass_empty,
        description: 'صفحة عامة أو مخصصة.',
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const EmptyNowPage()),
        ),
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Saed Generator'),
        centerTitle: true,
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 900),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 40),
            child: LayoutBuilder(
              builder: (context, constraints) {
                final isWide = constraints.maxWidth > 700;
                return GridView.count(
                  crossAxisCount: isWide ? 2 : 1,
                  mainAxisSpacing: 32,
                  crossAxisSpacing: 32,
                  shrinkWrap: true,
                  childAspectRatio: isWide ? 2.2 : 1.7,
                  physics: const NeverScrollableScrollPhysics(),
                  children: cardItems.map((item) => _HomeCard(item: item)).toList(),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

class _HomeCardData {
  final String title;
  final IconData icon;
  final String description;
  final VoidCallback onTap;
  const _HomeCardData({required this.title, required this.icon, required this.description, required this.onTap});
}

class _HomeCard extends StatefulWidget {
  final _HomeCardData item;
  const _HomeCard({required this.item, super.key});

  @override
  State<_HomeCard> createState() => _HomeCardState();
}

class _HomeCardState extends State<_HomeCard> {
  bool _hovering = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovering = true),
      onExit: (_) => setState(() => _hovering = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        curve: Curves.easeInOut,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              color: _hovering ? Colors.blue.withOpacity(0.18) : Colors.black12,
              blurRadius: _hovering ? 18 : 8,
              offset: const Offset(0, 4),
            ),
          ],
          border: Border.all(
            color: _hovering ? Colors.blue : Colors.grey.shade300,
            width: _hovering ? 2 : 1,
          ),
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(18),
            onTap: widget.item.onTap,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 28),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.blue.shade100,
                      borderRadius: BorderRadius.circular(14),
                    ),
                    padding: const EdgeInsets.all(18),
                    child: Icon(widget.item.icon, size: 38, color: Colors.blue.shade700),
                  ),
                  const SizedBox(width: 32),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          widget.item.title,
                          style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          widget.item.description,
                          style: TextStyle(fontSize: 15, color: Colors.grey.shade700),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _HomeButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final VoidCallback onTap;
  const _HomeButton({required this.label, required this.icon, required this.onTap, super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        icon: Icon(icon, size: 24),
        label: Padding(
          padding: const EdgeInsets.symmetric(vertical: 4.0),
          child: Text(label, style: const TextStyle(fontSize: 16)),
        ),
        style: ElevatedButton.styleFrom(
          minimumSize: const Size(0, 40),
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        onPressed: onTap,
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(),
      body: Row(
        children: [
          Expanded(
              child: Container(
            height: 200.0,
            color: Colors.amber,
          )),
          Expanded(
              child: Container(
            height: 200.0,
            color: Colors.amber,
          )),
        ],
      ),
    );
  }
}

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
                    _ModernTextField(
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
                    _ModernTextField(
                      controller: nameServiceController,
                      label: 'اسم الخدمة',
                      icon: Icons.miscellaneous_services,
                      hint: 'مثال: user',
                    ),
                    const SizedBox(height: 16),
                    _ModernTextField(
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
                          createFoldersAndFiles();
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

class _ModernTextField extends StatelessWidget {
  const _ModernTextField({
    required this.controller,
    required this.label,
    required this.icon,
    this.hint,
    this.suffix,
    super.key,
  });
  final TextEditingController controller;
  final String label;
  final IconData icon;
  final String? hint;
  final Widget? suffix;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: Colors.blue),
        hintText: hint,
        suffixIcon: suffix,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        filled: true,
        fillColor: Colors.blue.withOpacity(0.05),
      ),
      style: const TextStyle(fontSize: 16),
    );
  }
}

class AddCubitPage extends StatefulWidget {
  const AddCubitPage({super.key});
  @override
  State<AddCubitPage> createState() => _AddCubitPageState();
}

class _AddCubitPageState extends State<AddCubitPage> {
  final rootFolderController = TextEditingController();
  final nameServiceController = TextEditingController();
  final apiNameController = TextEditingController();
  final cubitSubFolderController = TextEditingController();
  bool isLoading = false;

  Future<void> _pickRootFolder() async {
    String? selectedDirectory = await FilePicker.platform.getDirectoryPath();
    if (selectedDirectory != null && selectedDirectory.isNotEmpty) {
      rootFolderController.text = selectedDirectory;
      setState(() {});
    }
  }

  Future<void> _pickCubitSubFolder() async {
    String? selectedDirectory = await FilePicker.platform.getDirectoryPath();
    if (selectedDirectory != null && selectedDirectory.isNotEmpty) {
      cubitSubFolderController.text = selectedDirectory;
      setState(() {});
    }
  }

  Future<void> _createCubit() async {
    setState(() => isLoading = true);
    try {
      await addCubitG(
        rootFolderInput: rootFolderController.text.trim(),
        nameServiceInput: nameServiceController.text.trim(),
        apiNameInput: apiNameController.text.trim(),
        cubitSubFolderInput: cubitSubFolderController.text.trim(),
      );
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('تم إنشاء الكيوبت بنجاح!')));
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('حدث خطأ: $e')));
    } finally {
      setState(() => isLoading = false);
    }
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
                      _ModernTextField(
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
                      _ModernTextField(
                        controller: nameServiceController,
                        label: 'اسم الخدمة',
                        icon: Icons.miscellaneous_services,
                        hint: 'مثال: user',
                      ),
                      const SizedBox(height: 12),
                      _ModernTextField(
                        controller: apiNameController,
                        label: 'اسم الـ API',
                        icon: Icons.api,
                        hint: 'مثال: user_api',
                      ),
                      const SizedBox(height: 12),
                      _ModernTextField(
                        controller: cubitSubFolderController,
                        label: 'اسم مجلد الكيوبت (مثال: user_cubit)',
                        icon: Icons.folder_special,
                        hint: 'مثال: user_cubit',
                        suffix: IconButton(
                          icon: const Icon(Icons.folder_open, color: Colors.blue),
                          tooltip: 'اختيار مجلد...',
                          onPressed: _pickCubitSubFolder,
                        ),
                      ),
                      const SizedBox(height: 24),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton.icon(
                          icon: isLoading
                              ? const SizedBox(
                                  width: 24, height: 24, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
                              : const Icon(Icons.add),
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
                          onPressed: isLoading ? null : _createCubit,
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

class AddServiceCubitPage extends StatelessWidget {
  const AddServiceCubitPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Service Cubit')),
      body: const Center(child: Text('صفحة إضافة Service Cubit (سيتم تطويرها لاحقاً)')),
    );
  }
}

class EmptyNowPage extends StatelessWidget {
  const EmptyNowPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Empty Now')),
      body: const Center(child: Text('لا يوجد محتوى حالياً')), // يمكن تطويرها لاحقاً
    );
  }
}
