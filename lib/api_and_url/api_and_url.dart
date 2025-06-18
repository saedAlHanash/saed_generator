import 'dart:io';

import 'package:saed_generator/api_and_url/texts/api_url_text.dart';
import 'package:saed_generator/extinctions.dart';

import 'package:path/path.dart';

import '../const_data.dart';

Future<void> addUrls() async {
  var apiUrlPath = await 'api_url.dart'.findFilesByName;

  if (apiUrlPath == null) {
    final corDir = await Directory(join(rootFolder, 'lib', 'core')).create(recursive: true);
    final apiManagerDir = await Directory(join(corDir.path, 'api_manager')).create(recursive: true);
    final file = File(join(apiManagerDir.path, 'api_url.dart'));
    apiUrlPath = (await file.create(recursive: true)).path;
    // file.writeAsString(apiText);
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

Future<void> initial() async {}
