import 'dart:io';
import 'package:path/path.dart' as path;
import '../const_data.dart';
import '../utile.dart';
import 'texts/item_cubit.dart';
import 'texts/item_state.dart';
import '../inject/inject_g.dart';
import '../api_and_url/api_and_url.dart';

Future<void> addCubitG({
  required String rootFolderInput,
  required String nameServiceInput,
  required String apiNameInput,
  required String cubitSubFolderInput, // اسم مجلد الكيوبت من المستخدم
}) async {
  rootFolder = rootFolderInput;
  nameService = nameServiceInput;
  apiName = apiNameInput;

  nameProject = await getProjectname;

  final cubitSubFolder = Directory(path.join(cubitSubFolderInput, nameServiceSC));

  await cubitSubFolder.create(recursive: true);

  // 3. توليد ملفات الكيوبت
  final cubitFile = File(path.join(cubitSubFolder.path, '${nameServiceSC}_cubit.dart'));
  final stateFile = File(path.join(cubitSubFolder.path, '${nameServiceSC}_state.dart'));
  await cubitFile.writeAsString(itemCubit);
  await stateFile.writeAsString(itemState);

  // 4. تحديث inject وURLs
  await inject();
  await addUrls();
}
