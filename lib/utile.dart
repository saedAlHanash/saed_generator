import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:path/path.dart' as p;
import 'package:path/path.dart' as path;
import 'package:saed_generator/extinctions.dart';
// import 'package:saed_generator/extinctions.dart';

String rootFolder = '';
String nameServiceCC = '';
String nameServiceSC = '';
String apiName = '';
String nameProject = '';

Future<String?> findFilesByName(String fileName) async {
  final List<String> foundFiles = [];

  final rootDir = Directory(rootFolder);

  if (!await rootDir.exists()) {
    debugPrint("Root folder does not exist.");
    return foundFiles.firstOrNull;
  }

  await for (var entity in rootDir.list(recursive: true, followLinks: false)) {
    if (entity is File) {
      if (path.basename(entity.path) == fileName) {
        foundFiles.add(entity.path);
      }
    }
  }

  return foundFiles.firstOrNull;
}

Future<String?> findDirectoriesByName(String rootFolder, String dirName) async {
  final List<String> foundDirs = [];

  final rootDir = Directory(rootFolder);

  if (!await rootDir.exists()) {
    print("Root folder does not exist.");
    return foundDirs.firstOrNull;
  }

  await for (var entity in rootDir.list(recursive: true, followLinks: false)) {
    if (entity is Directory) {
      if (path.basename(entity.path) == dirName) {
        foundDirs.add(entity.path);
      }
    }
  }

  return foundDirs.firstOrNull;
}

Future<void> addUrls() async {
  final apiUrlPath = await findFilesByName('api_url.dart');

  if (apiUrlPath == null) {
    print("ملف api_url.dart غير موجود.");
    return;
  }
  final file = File(apiUrlPath);

  final lines = await file.readAsLines();
  final modifiedLines = <String>[];

  for (var i = 0; i < lines.length; i++) {
    final line = lines[i];
    modifiedLines.add(line);

    if (line.contains('class GetUrl {')) {
      modifiedLines.add("  static const $nameServiceCC = '$apiName/Get';");
    } else if (line.contains('class PostUrl {')) {
      modifiedLines.add("  static const ${nameServiceCC}s = '$apiName/GetAll';");
      modifiedLines.add("  static const create$nameServiceCC = '$apiName/Add';");
    } else if (line.contains('class PutUrl {')) {
      modifiedLines.add("  static const update$nameServiceCC = '$apiName/Update';");
    } else if (line.contains('class DeleteUrl {')) {
      modifiedLines.add("  static const delete$nameServiceCC = '$apiName/Delete';");
    }
  }

  await file.writeAsString(modifiedLines.join('\n'));
  print("تم تعديل ملف api_url.dart بنجاح.");
}

Future<void> inject() async {
  final injectionPath = await findFilesByName('injection_container.dart');
  if (injectionPath == null) {
    print("ملف injection_container.dart غير موجود.");
    return;
  }

  final file = File(injectionPath);

  final lines = await file.readAsLines();

  final modifiedLines = <String>[];

  final importStatement =
      '''
import 'package:$nameProject/features/$nameServiceSC/bloc/create_${nameServiceSC}_cubit/create_${nameServiceSC}_cubit.dart';
import 'package:$nameProject/features/$nameServiceSC/bloc/delete_${nameServiceSC}_cubit/delete_${nameServiceSC}_cubit.dart';
import 'package:$nameProject/features/$nameServiceSC/bloc/${nameServiceSC}_cubit/${nameServiceSC}_cubit.dart';
import 'package:$nameProject/features/$nameServiceSC/bloc/${nameServiceSC}s_cubit/${nameServiceSC}s_cubit.dart';
''';

  modifiedLines.add(importStatement);
  bool inserted = false;

  for (var i = 0; i < lines.length; i++) {
    final line = lines[i];
    modifiedLines.add(line);

    if (!inserted && line.contains('Future<void> init() async {')) {
      modifiedLines.add('''
      
  //region $nameServiceCC
  sl.registerFactory(() => Create${nameServiceCC}Cubit());
  sl.registerFactory(() => Delete${nameServiceCC}Cubit());
  sl.registerFactory(() => ${nameServiceCC}Cubit());
  sl.registerFactory(() => ${nameServiceCC}sCubit());
  //endregion
  
''');
      inserted = true;
    }
  }

  await file.writeAsString(modifiedLines.join('\n'));
  print("تم تعديل الملف بنجاح.");
}

Future<void> createFoldersAndFiles() async {
  final yaml = await findFilesByName('pubspec.yaml');
  if (yaml == null) {
    print("Project name not found.");
    return;
  }

  await addUrls();

  await inject();

  final serviceFolder = path.join(rootFolder, nameServiceSC);

  await Directory(serviceFolder).create(recursive: true);

  final blocFolder = path.join(serviceFolder, 'bloc');
  final dataFolder = path.join(serviceFolder, 'data');
  final uiFolder = path.join(serviceFolder, 'ui');

  await Directory(blocFolder).create(recursive: true);
  await Directory(dataFolder).create(recursive: true);
  await Directory(uiFolder).create(recursive: true);

  final createCubitTemplate = "";
  final createStateTemplate = "";

  final deleteCubitTemplate = "";
  final deleteStateTemplate = "";

  final tempCubitTemplate = "";
  final tempStateTemplate = "";

  final tempsCubitTemplate = "";
  final tempsStateTemplate = "";

  final blocSubFolders = [
    'create_${nameServiceSC}_cubit',
    'delete_${nameServiceSC}_cubit',
    '${nameServiceSC}_cubit',
    '${nameServiceSC}s_cubit',
  ];

  for (final subFolder in blocSubFolders) {
    final subFolderPath = path.join(blocFolder, subFolder);
    await Directory(subFolderPath).create(recursive: true);

    final baseName = subFolder.replaceAll('_cubit', '');

    if (subFolder.contains('create')) {
      await File(path.join(subFolderPath, '${baseName}_cubit.dart')).writeAsString(createCubitTemplate);

      await File(path.join(subFolderPath, '${baseName}_state.dart')).writeAsString(createStateTemplate);
    } else if (subFolder.contains('delete')) {
      await File(path.join(subFolderPath, '${baseName}_cubit.dart')).writeAsString(deleteCubitTemplate);

      await File(path.join(subFolderPath, '${baseName}_state.dart')).writeAsString(deleteStateTemplate);
    } else if (subFolder == '${nameServiceSC}_cubit') {
      await File(path.join(subFolderPath, '${baseName}_cubit.dart')).writeAsString(tempCubitTemplate);

      await File(path.join(subFolderPath, '${baseName}_state.dart')).writeAsString(tempStateTemplate);
    } else if (subFolder == '${nameServiceSC}s_cubit') {
      await File(path.join(subFolderPath, '${baseName}_cubit.dart')).writeAsString(tempsCubitTemplate);

      await File(path.join(subFolderPath, '${baseName}_state.dart')).writeAsString(tempsStateTemplate);
    }
  }

  // مجلدات فرعية في data
  final dataSubFolders = ['request', 'response'];
  for (final subFolder in dataSubFolders) {
    final folderPath = path.join(dataFolder, subFolder);
    await Directory(folderPath).create(recursive: true);
  }

  final responseFilePath = path.join(dataFolder, 'response', '${nameServiceSC}_response.dart');
  final responseTemplate = "";

  await File(responseFilePath).writeAsString(responseTemplate);

  final requestFilePath = path.join(dataFolder, 'request', 'create_${nameServiceSC}_request.dart');
  final requestTemplate = "";

  await File(requestFilePath).writeAsString(requestTemplate);

  // مجلدات فرعية في ui
  final uiSubFolders = ['pages', 'widgets'];
  for (final subFolder in uiSubFolders) {
    final folderPath = path.join(uiFolder, subFolder);
    await Directory(folderPath).create(recursive: true);
  }

  print('Folder structure created successfully under: $serviceFolder');
}
