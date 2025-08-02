import '../../const_data.dart';

String addCubitTemplate({
  required String nameProject,
  required String cubitNameSC,
  required String cubitNamePC,
  required String cubitNameCC,
}) =>
    '''
import 'package:$nameProject/core/api_manager/api_service.dart';
import 'package:$nameProject/core/api_manager/api_url.dart';
import 'package:$nameProject/core/extensions/extensions.dart';
import 'package:$nameProject/core/strings/enum_manager.dart';
import 'package:$nameProject/core/util/pair_class.dart';
import 'package:$nameProject/features/$cubitNameSC/data/response/${cubitNameSC}_response.dart';
import 'package:m_cubit/abstraction.dart';

part '${cubitNameSC}_state.dart';

class ${cubitNamePC}Cubit extends MCubit<${cubitNamePC}Initial> {
 ${cubitNamePC}Cubit() : super(${cubitNamePC}Initial.initial());

  @override
  String get nameCache => '$cubitNameCC';

  @override
  String get filter => state.filter;

  Future<void> getData({bool newData = false,  String? ${cubitNameCC}Id}) async {
    emit(state.copyWith(request: ${cubitNameCC}Id));

    await getDataAbstract(
      fromJson: $cubitNamePC.fromJson,
      state: state,
      getDataApi: _getData,
      newData: newData,
    );
  }

  Future<Pair<$cubitNamePC?, String?>> _getData() async {
    final response = await APIService().callApi(
      type: ApiType.get,
      url: GetUrl.$cubitNameCC,
      query: {'Id': state.request},
    );

    if (response.statusCode.success) {
      return Pair($cubitNamePC.fromJson(response.jsonBody), null);
    } else {
      return response.getPairError;
    }
  }

  void set$cubitNamePC(dynamic $cubitNameCC) {
    if ($cubitNameCC is! $cubitNamePC) return;
    emit(state.copyWith(result: $cubitNameCC));
  }
}
''';
