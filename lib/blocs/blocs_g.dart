import 'dart:io';

import 'package:path/path.dart' as path;
import 'package:saed_generator/extinctions.dart';
import 'package:saed_generator/blocs/texts/item_cubit.dart';
import 'package:saed_generator/blocs/texts/item_state.dart';
import 'package:saed_generator/blocs/texts/items_cubit.dart';
import 'package:saed_generator/blocs/texts/items_state.dart';

import '../const_data.dart';

Future<void> blocs() async {
  final features = await 'features'.findOrCreateAndEnterDirectory;
  if (features == null) return;
  final serviceFolder = path.join(features, nameServiceSC);

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
