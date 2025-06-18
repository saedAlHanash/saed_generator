import 'dart:io';

import 'package:path/path.dart' as path;
import 'package:saed_generator/extinctions.dart';
import 'package:saed_generator/ui/texts/item_widget_g.dart';
import 'package:saed_generator/ui/texts/list_page_g.dart';
import 'package:saed_generator/ui/texts/page_g.dart';

import '../const_data.dart';

Future<void> uiFolder() async {
  final features  = await 'features'.findOrCreateAndEnterDirectory;
  if(features==null)return;
  final serviceFolder = path.join(features, nameServiceSC);

  final uiFolder = path.join(serviceFolder, 'ui');
  await Directory(uiFolder).create(recursive: true);

  final uiSubFolders = ['pages', 'widgets'];
  for (final subFolder in uiSubFolders) {
    final folderPath = path.join(uiFolder, subFolder);
    await Directory(folderPath).create(recursive: true);
  }

  final pagesSubFiles = ['${nameServiceSC}_page.dart', '${nameServiceSC}s_page.dart'];
  for (final subFiles in pagesSubFiles) {
    final folderPath = path.join(uiFolder, 'pages', subFiles);
    final file = File(folderPath);
    await file.create(recursive: true);
    file.writeAsString(subFiles != pagesSubFiles.first ? listPage : pageG);
  }

  final widgetsSubFolders = ['item_$nameServiceSC.dart'];
  for (final subFolder in widgetsSubFolders) {
    final folderPath = path.join(uiFolder, 'widgets', subFolder);
    final file = File(folderPath);
    await file.create(recursive: true);
    file.writeAsString(subFolder == widgetsSubFolders.first ? itemWidget : '');
  }
}
