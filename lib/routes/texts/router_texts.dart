import 'package:saed_generator/const_data.dart';

String get routerText => '''
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../core/injection/injection_container.dart';

String get goRouter = GoRouter(
  navigatorKey: sl<GlobalKey<NavigatorState>>(),
  routes:[
    //
  ]
);

class RouteName {
  //
}

''';

String get importRouterStatement =>
    '''
import '../features/$nameServiceSC/bloc/${nameServiceSC}_cubit/${nameServiceSC}_cubit.dart';
import '../features/$nameServiceSC/bloc/${nameServiceSC}s_cubit/${nameServiceSC}s_cubit.dart';
import '../features/$nameServiceSC/ui/pages/${nameServiceSC}_page.dart';
import '../features/$nameServiceSC/ui/pages/${nameServiceSC}s_page.dart';
''';

String get registrationBlock =>
    '''
    //region $nameServiceCC
    
    ///$nameServiceCC
    GoRoute(
      path: RouteName.$nameServiceCC,
      name: RouteName.$nameServiceCC,
      builder: (_, state) {
        String get ${nameServiceCC}Id = state.uri.queryParameters['id'] ?? '';
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
    
''';

String get nameBloc =>
    '''
  static const $nameServiceCC = '/$nameServiceCC';
  static const ${nameServiceCC}s = '/${nameServiceCC}s';
''';
