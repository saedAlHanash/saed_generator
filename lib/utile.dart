import 'dart:io';

import 'package:path/path.dart' as path;
import 'package:saed_generator/extinctions.dart';
import 'package:saed_generator/data/texts/request.dart';
import 'package:saed_generator/data/texts/response.dart';
import 'package:saed_generator/routes/routes_g.dart';
import 'package:saed_generator/ui/ui_g.dart';

import 'api_and_url/api_and_url.dart';
import 'blocs/blocs_g.dart';
import 'const_data.dart';
import 'data/data_g.dart';
import 'inject/inject_g.dart';

Future<String> get getProjectname async {
  final yaml = await 'pubspec.yaml'.findFilesByName;

  if (yaml == null) {
    print("Project name not found.");
    return '';
  }
  final pubspecFile = File(yaml);
  // التحقق من وجود الملف
  if (await pubspecFile.exists()) {
    final lines = await pubspecFile.readAsLines();

    for (final line in lines) {
      if (line.trimLeft().startsWith('name:')) {
        final nameValue = line.split(':').last.trim();
        return nameValue;
      }
    }
  }
  return '';
}

Future<void> createFoldersAndFiles() async {
  // nameProject = await getProjectname;

  await addUrls();

  await inject();

  await blocs();

  await dataFolder();

  await uiFolder();

  await routeG();
}
