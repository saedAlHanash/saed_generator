import '../../const_data.dart';

final injectText = '''
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sl = GetIt.instance;
Future<void> init() async {


  //region Core

  sl.registerLazySingleton(() => GlobalKey<NavigatorState>());

  // sl.registerLazySingleton(() => ProtectScreenService());

  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  
  //endregion
}
''';

final importStatement =
    '''
      
import 'package:$nameProject/features/$nameServiceSC/bloc/${nameServiceSC}_cubit/${nameServiceSC}_cubit.dart';
import 'package:$nameProject/features/$nameServiceSC/bloc/${nameServiceSC}s_cubit/${nameServiceSC}s_cubit.dart';

''';

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
