import 'dart:io';

import 'package:path/path.dart' as path;
import 'package:saed_generator/extinctions.dart';
import 'package:saed_generator/data/texts/request.dart';
import 'package:saed_generator/data/texts/response.dart';

import '../const_data.dart';

Future<void> dataFolder() async {
  final serviceFolder = path.join(await 'features'.findOrCreateAndEnterDirectory, nameServiceSC);

  final dataFolder = path.join(serviceFolder, 'data');
  await Directory(dataFolder).create(recursive: true);

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
