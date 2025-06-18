import 'package:saed_generator/extinctions.dart';
import 'dart:io';

import 'package:path/path.dart';
import 'package:saed_generator/routes/texts/router_texts.dart';

import '../const_data.dart';

Future<void> routeG() async {
  var fileRoute = await 'go_router.dart'.findFilesByName;
  // fileRoute ??= await checkAndCreate(fileRoute);

  if (fileRoute == null) return;
  final file = File(fileRoute);
  final lines = await file.readAsLines();

  final existingLines = lines.toSet();

  final modifiedLines = <String>[];

  if (!existingLines.contains(importRouterStatement.trim())) {
    modifiedLines.add(importRouterStatement);
  }

  bool insertRoute = false;
  bool insertNames = false;

  for (var i = 0; i < lines.length; i++) {
    final line = lines[i];
    modifiedLines.add(line);

    final c = '$nameServiceCC $nameService';
    if (!insertRoute && line.contains('routes')) {
      modifiedLines.add(registrationBlock);
      insertRoute = true;
    }
    if (!insertNames && line.contains('class RouteName {')) {
      modifiedLines.add(nameBloc);
      insertNames = true;
    }
  }

  await file.writeAsString(modifiedLines.join('\n'));
}

Future<String> checkAndCreate(String? fileRoute) async {
  final routerDir = await Directory(join(rootFolder, 'lib', 'router')).create(recursive: true);

  final file = File(join(routerDir.path, 'app_router.dart'));
  await file.writeAsString(routerText);
  return ((await file.create(recursive: true)).path);
}
