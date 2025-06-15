import 'dart:io';

import 'package:path/path.dart';

import 'const_data.dart';

extension IterableExtensions<E> on Iterable<E> {
  Iterable<T> mapIndexed<T>(T Function(int index, E item) f) {
    var index = 0;
    return map((e) => f(index++, e));
  }
}

extension StringH on String {
  String get toSnakeCase {
    if (isEmpty) {
      return '';
    }
    // Handle cases where there's already an underscore (likely already snake_case or similar)
    // or if it's a single word (no case changes needed, just lowercase).
    if (contains('_') || !contains(RegExp(r'[A-Z]'))) {
      return toLowerCase().replaceAll(' ', '_');
    }

    final regex = RegExp(r'(?<=[a-z])(?=[A-Z])|(?<=[A-Z])(?=[A-Z][a-z])');
    return this.split(regex).map((s) => s.toLowerCase()).join('_');
  }

  String get toPascalCase {
    if (isEmpty) {
      return '';
    }
    // Split by underscore or by capital letters for camelCase/snake_case inputs
    final words = this.split(RegExp(r'_|(?<=[a-z])(?=[A-Z])|(?<=[A-Z])(?=[A-Z][a-z])'));
    if (words.isEmpty) return '';
    return words.map((word) {
      if (word.isEmpty) return '';
      return word[0].toUpperCase() + word.substring(1).toLowerCase();
    }).join();
  }

  String get toCamelCase {
    if (isEmpty) {
      return '';
    }
    final pascalCase = toPascalCase;
    if (pascalCase.isEmpty) return '';
    return pascalCase[0].toLowerCase() + pascalCase.substring(1);
  }

  Future<String?> get findFilesByName async {
    final List<String> foundFiles = [];

    final libDir = Directory(join(rootFolder, 'lib'));

    if (!await libDir.exists()) {
      return null;
    }

    try {
      await for (var entity in libDir.list(recursive: true, followLinks: false)) {
        if (entity is File && basename(entity.path) == this) {
          foundFiles.add(entity.path);
        }
      }
    } catch (e) {
      print('____$e');
    }

    return foundFiles.isNotEmpty ? foundFiles.first : null;
  }

  Future<String> get findOrCreateAndEnterDirectory async {
    final rootDir = Directory(rootFolder);

    await for (var entity in rootDir.list(recursive: true, followLinks: false)) {
      if (entity is Directory && basename(entity.path) == this) {
        return entity.path;
      }
    }

    final libPath = join(rootDir.path, 'lib');

    await Directory(libPath).create(recursive: true);

    return libPath;
  }
}
