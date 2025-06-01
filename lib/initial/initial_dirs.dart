import 'dart:io';
import 'package:path/path.dart' as path;

Future<void> createFolderStructure(Directory baseDir, Map<String, List<String>> structure) async {
  try {
    // إنشاء المجلد الأساسي إذا لم يكن موجودًا
    if (!await baseDir.exists()) {
      await baseDir.create(recursive: true);
    }

    // إنشاء كل مجلد رئيسي ومجلداته الفرعية
    for (final parentFolder in structure.keys) {
      final parentDir = Directory(path.join(baseDir.path, parentFolder));

      // إنشاء المجلد الرئيسي
      if (!await parentDir.exists()) {
        await parentDir.create();
      }

      // إنشاء المجلدات الفرعية
      for (final subFolder in structure[parentFolder]!) {
        final subDir = Directory(path.join(parentDir.path, subFolder));
        if (!await subDir.exists()) {
          await subDir.create();
        }
      }
    }
  } catch (e) {
    print('حدث خطأ أثناء إنشاء المجلدات: $e');
  }
}
