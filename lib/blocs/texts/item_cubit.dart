import '../../const_data.dart';

import '../../const_data.dart';

final itemCubit =
    '''
import 'package:$nameProject/core/api_manager/api_service.dart';
import 'package:$nameProject/core/api_manager/api_url.dart';
import 'package:$nameProject/core/extensions/extensions.dart';
import 'package:$nameProject/core/strings/enum_manager.dart';
import 'package:$nameProject/core/util/pair_class.dart';
import 'package:$nameProject/features/$nameServiceSC/data/response/${nameServiceSC}_response.dart';
import 'package:m_cubit/abstraction.dart';

part '${nameServiceSC}_state.dart';

class ${nameServicePC}Cubit extends MCubit<${nameServicePC}Initial> {
  ${nameServicePC}Cubit() : super(${nameServicePC}Initial.initial());

  @override
  String get nameCache => '$nameServiceCC';

  @override
  String get filter => state.filter;

  Future<void> getData({bool newData = false, required String ${nameServiceCC}Id}) async {
    emit(state.copyWith(request: ${nameServiceCC}Id));

    await getDataAbstract(
      fromJson: $nameServicePC.fromJson,
      state: state,
      getDataApi: _getData,
      newData: newData,
    );
  }

  Future<Pair<$nameServicePC?, String?>> _getData() async {
    final response = await APIService().callApi(
      type: ApiType.get,
      url: GetUrl.$nameServiceCC,
      query: {'Id': state.request},
    );

    if (response.statusCode.success) {
      return Pair($nameServicePC.fromJson(response.jsonBody), null);
    } else {
      return response.getPairError;
    }
  }

  void set$nameServicePC(dynamic $nameServiceCC) {
    if ($nameServiceCC is! $nameServicePC) return;

    emit(state.copyWith(result: $nameServiceCC));
  }
}
 ''';
