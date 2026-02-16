import 'package:flutter/material.dart';
import 'package:saed_generator/pages/create_full_page.dart';
import 'package:saed_generator/utile.dart';

import '../const_data.dart';
import 'package:file_picker/file_picker.dart';

import 'pages/create_cubit_page.dart';

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

  const _HomeCard({required this.item});

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

class ModernTextField extends StatelessWidget {
  const ModernTextField({
    required this.controller,
    required this.label,
    required this.icon,
    this.hint,
    this.suffix,
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
