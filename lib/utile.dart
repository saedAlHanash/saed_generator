import 'dart:io';

import 'package:path/path.dart' as path;
import 'package:saed_generator/api_and_url/api_and_url_cubit.dart';
import 'package:saed_generator/routes/routes_g.dart';
import 'package:saed_generator/ui/ui_g.dart';

import 'api_and_url/api_and_url.dart';
import 'blocs/blocs_g.dart';
import 'const_data.dart';
import 'data/data_g.dart';
import 'inject/inject_g.dart';

enum CreateCubitType {
  get,
  crud,
  empty;

  List<String> get getSubFolder => switch (this) {
        CreateCubitType.get => ['${nameServiceSC}_cubit'],
        CreateCubitType.crud => ['${nameServiceSC}_cubits'],
        CreateCubitType.empty => ['${nameServiceSC}_cubit'],
      };

  String get registrationLine1 => switch (this) {
        (CreateCubitType.get || CreateCubitType.empty) => "sl.registerFactory(() => ${nameServicePC}Cubit());",
        CreateCubitType.crud => "sl.registerFactory(() => ${nameServicePC}sCubit());",
      };

  String get registrationBlock => '''
  //region $nameServiceCC
  $registrationLine1
  //endregion
''';

  String get importRouterStatement => '''${switch (this) {
        (CreateCubitType.get || CreateCubitType.empty) => '''
import '../features/$nameServiceSC/bloc/${nameServiceSC}_cubit/${nameServiceSC}_cubit.dart';
import '../features/$nameServiceSC/ui/pages/${nameServiceSC}_page.dart';
        ''',
        CreateCubitType.crud => '''
import '../features/$nameServiceSC/bloc/${nameServiceSC}s_cubit/${nameServiceSC}s_cubit.dart';
import '../features/$nameServiceSC/ui/pages/${nameServiceSC}s_page.dart';''',
      }}
''';

  String get registrationBlockRoute => switch (this) {
        (CreateCubitType.get || CreateCubitType.empty) => '''
    //region $nameServiceCC
    
    ///$nameServiceCC
    GoRoute(
      path: RouteName.$nameServiceCC,
      name: RouteName.$nameServiceCC,
      builder: (_, state) {
        String  ${nameServiceCC}Id = state.uri.queryParameters['id'] ?? '';
        return MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => sl<${nameServicePC}Cubit>()..getData(${nameServiceCC}Id: ${nameServiceCC}Id),
            ),
          ],
          child: ${nameServicePC}Page(),
        );
      },
    ),
    
    //endregion
    
''',
        CreateCubitType.crud => '''
    //region $nameServiceCC
    
    ///${nameServiceCC}s
    GoRoute(
      path: RouteName.${nameServiceCC}s,
      name: RouteName.${nameServiceCC}s,
      builder: (_, state) {
        return MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => sl<${nameServicePC}sCubit>()..getData(),
            ),
          ],
          child: ${nameServicePC}sPage(),
        );
      },
    ),
    //endregion
    
'''
      };

  String get nameBloc => switch (this) {
        (CreateCubitType.get || CreateCubitType.empty) => '''
  static const $nameServiceCC = '/$nameServiceCC';
''',
        CreateCubitType.crud => '''
  static const ${nameServiceCC}s = '/${nameServiceCC}s';
''',
      };
}

Future<String> get getProjectname async {
  final file = File(path.join(rootFolder, 'pubspec.yaml'));
  if (!(await file.exists())) return 'PROJECT_NAME';

  final lines = await file.readAsLines();

  for (final line in lines) {
    if (line.trimLeft().startsWith('name:')) {
      final nameValue = line.split(':').last.trim();
      return nameValue;
    }
  }

  return '';
}

Future<void> createFullService() async {
  nameProject = await getProjectname;

  await addUrls();

  await inject();

  await blocs();

  await dataFolder();

  await uiFolder();

  await routeG();
}

Future<void> createCubit({
  required CreateCubitType type,
}) async {
  nameProject = await getProjectname;

  await addUrlsCubit(type);

  await inject(type: type);

  await cubit(type);

  await routeG(type: type);
}
