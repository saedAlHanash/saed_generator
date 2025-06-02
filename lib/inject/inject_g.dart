import 'dart:io';

import 'package:path/path.dart';
import 'package:saed_generator/extinctions.dart';
import 'package:saed_generator/inject/text/inject_text.dart';

import '../const_data.dart';

Future<void> inject() async {
  var injectionPath = await 'injection_container.dart'.findFilesByName;

  injectionPath ??= await checkAndCreate(injectionPath);

  final file = File(injectionPath);

  final lines = await file.readAsLines();

  final existingLines = lines.toSet();

  final modifiedLines = <String>[];

  if (!existingLines.contains(importStatement.trim())) {
    modifiedLines.add(importStatement);
  }

  bool inserted = false;

  for (var i = 0; i < lines.length; i++) {
    final line = lines[i];
    modifiedLines.add(line);

    if (!inserted &&
        line.contains('Future<void> init() async {') &&
        !existingLines.contains(registrationLine1) &&
        !existingLines.contains(registrationLine2)) {
      modifiedLines.add(registrationBlock);
      inserted = true;
    }
  }

  await file.writeAsString(modifiedLines.join('\n'));
}

Future<String> checkAndCreate(String? injectionPath) async {
  final corDir = await Directory(join(rootFolder, 'lib', 'core')).create(recursive: true);
  final apiManagerDir = await Directory(join(corDir.path, 'injection')).create(recursive: true);
  final file = File(join(apiManagerDir.path, 'injection_container.dart'));
  file.writeAsString(injectText);
  return ((await file.create(recursive: true)).path);
}
