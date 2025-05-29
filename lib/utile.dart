import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:path/path.dart' as p;
import 'package:path/path.dart' as path;
import 'package:saed_generator/extinctions.dart';
import 'package:saed_generator/texts/item_cubit.dart';
import 'package:saed_generator/texts/item_state.dart';
import 'package:saed_generator/texts/items_cubit.dart';
import 'package:saed_generator/texts/items_state.dart';
import 'package:saed_generator/texts/request.dart';
import 'package:saed_generator/texts/response.dart';

import 'const_data.dart';

Future<void> addUrls() async {
  final apiUrlPath = await 'api_url.dart'.findFilesByName;

  if (apiUrlPath == null) {
    print("ملف api_url.dart غير موجود.");
    return;
  }
  final file = File(apiUrlPath);

  final lines = await file.readAsLines();
  final modifiedLines = <String>[];

  // تعريف الأسطر المحتملة
  final getLine = "  static const $nameServiceCC = '$apiName/Get';";
  final postLine1 = "  static const ${nameServiceCC}s = '$apiName/GetAll';";
  final postLine2 = "  static const create$nameServicePC = '$apiName/Add';";
  final putLine = "  static const update$nameServicePC = '$apiName/Update';";
  final deleteLine = "  static const delete$nameServicePC = '$apiName/Delete';";

  final existingLines = lines.toSet();

  for (var i = 0; i < lines.length; i++) {
    final line = lines[i];
    modifiedLines.add(line);

    if (line.contains('class GetUrl {') && !existingLines.contains(getLine)) {
      modifiedLines.add(getLine);
    } else if (line.contains('class PostUrl {')) {
      if (!existingLines.contains(postLine1)) modifiedLines.add(postLine1);
      if (!existingLines.contains(postLine2)) modifiedLines.add(postLine2);
    } else if (line.contains('class PutUrl {') && !existingLines.contains(putLine)) {
      modifiedLines.add(putLine);
    } else if (line.contains('class DeleteUrl {') && !existingLines.contains(deleteLine)) {
      modifiedLines.add(deleteLine);
    }
  }

  await file.writeAsString(modifiedLines.join('\n'));

  print("تم تعديل ملف api_url.dart بنجاح.");
}

Future<void> inject() async {
  final injectionPath = await 'injection_container.dart'.findFilesByName;
  if (injectionPath == null) {
    print("ملف injection_container.dart غير موجود.");
    return;
  }

  final file = File(injectionPath);
  final lines = await file.readAsLines();
  final existingLines = lines.toSet(); // لتسريع البحث

  final modifiedLines = <String>[];

  final importStatement =
      '''
import 'package:$nameProject/features/$nameServiceSC/bloc/${nameServiceSC}_cubit/${nameServiceSC}_cubit.dart';
import 'package:$nameProject/features/$nameServiceSC/bloc/${nameServiceSC}s_cubit/${nameServiceSC}s_cubit.dart';

''';

  // إضافة import فقط إذا لم يكن موجودًا
  if (!existingLines.contains(importStatement.trim())) {
    modifiedLines.add(importStatement);
  }

  bool inserted = false;

  for (var i = 0; i < lines.length; i++) {
    final line = lines[i];
    modifiedLines.add(line);

    // تحقق من وجود منطقة التسجيل مسبقاً
    final registrationLine1 = "  sl.registerFactory(() => ${nameServicePC}Cubit());";
    final registrationLine2 = "  sl.registerFactory(() => ${nameServicePC}sCubit());";

    final registrationBlock =
        '''
      
  //region $nameServiceCC
  $registrationLine1
  $registrationLine2
  //endregion
''';

    if (!inserted &&
        line.contains('Future<void> init() async {') &&
        !existingLines.contains(registrationLine1) &&
        !existingLines.contains(registrationLine2)) {
      modifiedLines.add(registrationBlock);
      inserted = true;
    }
  }

  await file.writeAsString(modifiedLines.join('\n'));
  print("تم تعديل الملف بنجاح.");
}

Future<void> blocs(String serviceFolder) async {
  await Directory(serviceFolder).create(recursive: true);

  final blocFolder = path.join(serviceFolder, 'bloc');
  await Directory(blocFolder).create(recursive: true);

  final blocSubFolders = ['${nameServiceSC}_cubit', '${nameServiceSC}s_cubit'];

  for (final subFolder in blocSubFolders) {
    final subFolderPath = path.join(blocFolder, subFolder);
    await Directory(subFolderPath).create(recursive: true);

    final baseName = subFolder.replaceAll('_cubit', '');

    if (subFolder == '${nameServiceSC}_cubit') {
      await File(path.join(subFolderPath, '${baseName}_cubit.dart')).writeAsString(itemCubit);

      await File(path.join(subFolderPath, '${baseName}_state.dart')).writeAsString(itemState);
    } else if (subFolder == '${nameServiceSC}s_cubit') {
      await File(path.join(subFolderPath, '${baseName}_cubit.dart')).writeAsString(itemsCubit);

      await File(path.join(subFolderPath, '${baseName}_state.dart')).writeAsString(itemsState);
    }
  }
}

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

Future<void> dataFolder(String serviceFolder) async {
  final dataFolder = path.join(serviceFolder, 'data');
  await Directory(dataFolder).create(recursive: true);
  // مجلدات فرعية في data
  final dataSubFolders = ['request', 'response'];

  for (final subFolder in dataSubFolders) {
    final folderPath = path.join(dataFolder, subFolder);
    await Directory(folderPath).create(recursive: true);
  }

  final responseFilePath = path.join(dataFolder, 'response', '${nameServiceSC}_response.dart');

  await File(responseFilePath).writeAsString(response);

  final requestFilePath = path.join(dataFolder, 'request', 'create_${nameServiceSC}_request.dart');

  await File(requestFilePath).writeAsString(request);
}

Future<void> uiFolder(String serviceFolder) async {
  final uiFolder = path.join(serviceFolder, 'ui');
  await Directory(uiFolder).create(recursive: true);

  final uiSubFolders = ['pages', 'widgets'];
  for (final subFolder in uiSubFolders) {
    final folderPath = path.join(uiFolder, subFolder);
    await Directory(folderPath).create(recursive: true);
  }
}

Future<void> createFoldersAndFiles() async {
  nameProject = await getProjectname;

  await addUrls();

  await inject();

  final serviceFolder = path.join(await 'features'.findOrCreateAndEnterDirectory, nameServiceSC);

  await blocs(serviceFolder);

  await dataFolder(serviceFolder);

  await uiFolder(serviceFolder);
}
