import 'dart:io';

import 'package:flutter/cupertino.dart';
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
    final regex = RegExp(r'(?<=[a-z])[A-Z]');
    return replaceAllMapped(regex, (match) => '_${match.group(0)}').toLowerCase();
  }

  String get toPascalCase {
    final words = split('_');
    return words.map((word) => word[0].toUpperCase() + word.substring(1)).join();
  }

  String get toCamelCase {
    final words = split('_');
    if (words.isEmpty) return '';
    final capitalized = words.map((word) => word[0].toUpperCase() + word.substring(1)).join();
    return capitalized[0].toLowerCase() + capitalized.substring(1);
  }

  Future<String?> get findFilesByName async {
    final List<String> foundFiles = [];

    final rootDir = Directory(rootFolder);

    if (!await rootDir.exists()) {
      return foundFiles.firstOrNull;
    }

    await for (var entity in rootDir.list(recursive: true, followLinks: false)) {
      if (entity is File) {
        if (basename(entity.path) == this) {
          foundFiles.add(entity.path);
        }
      }
    }

    return foundFiles.firstOrNull;
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
