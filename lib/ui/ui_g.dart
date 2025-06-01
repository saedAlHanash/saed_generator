import 'dart:io';

import 'package:path/path.dart' as path;
import 'package:saed_generator/extinctions.dart';

import '../const_data.dart';

Future<void> uiFolder() async {
  final serviceFolder = path.join(await 'features'.findOrCreateAndEnterDirectory, nameServiceSC);

  final uiFolder = path.join(serviceFolder, 'ui');
  await Directory(uiFolder).create(recursive: true);

  final uiSubFolders = ['pages', 'widgets'];
  for (final subFolder in uiSubFolders) {
    final folderPath = path.join(uiFolder, subFolder);
    await Directory(folderPath).create(recursive: true);
  }

  final pagesSubFolders = ['${nameServiceSC}Page', '${nameServiceSC}sPage'];
  for (final subFolder in pagesSubFolders) {
    final folderPath = path.join(uiFolder, uiSubFolders.first, subFolder);
    await Directory(folderPath).create(recursive: true);
  }
}
