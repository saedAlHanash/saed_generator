import '../../const_data.dart';

import '../../const_data.dart';

final itemsCubit =
    '''
import 'package:$nameProject/core/api_manager/api_service.dart';
import 'package:$nameProject/core/api_manager/api_url.dart';
import 'package:$nameProject/core/extensions/extensions.dart';
import 'package:$nameProject/core/strings/enum_manager.dart';
import 'package:$nameProject/core/util/pair_class.dart';
import 'package:$nameProject/features/$nameServiceSC/data/request/create_${nameServiceSC}_request.dart';
import 'package:$nameProject/features/$nameServiceSC/data/response/${nameServiceSC}_response.dart';
import 'package:http/http.dart';
import 'package:m_cubit/m_cubit.dart';

import '../../../../core/error/error_manager.dart';

part '${nameServiceSC}s_state.dart';

class ${nameServicePC}sCubit extends MCubit<${nameServicePC}sInitial> {
  ${nameServicePC}sCubit() : super(${nameServicePC}sInitial.initial()) {
    getDataFromCache();
  }

  @override
  String get nameCache => '${nameServiceCC}s';

  @override
  String get filter => state.filter;

  //region getData

  void getDataFromCache() => getFromCache(fromJson: $nameServicePC.fromJson, state: state);

  Future<void> getData({bool newData = false}) async {
    await getDataAbstract(
      fromJson: $nameServicePC.fromJson,
      state: state,
      getDataApi: _getData,
      newData: newData,
    );
  }

  Future<Pair<List<$nameServicePC>?, String?>> _getData() async {
    final response = await APIService().callApi(
      type: ApiType.post,
      url: PostUrl.${nameServiceCC}s,
      body: state.filterRequest?.toJson() ?? {},
    );

    if (response.statusCode.success) {
      return Pair(${nameServicePC}s.fromJson(response.jsonBody).items, null);
    } else {
      return response.getPairError;
    }
  }

  //endregion

  //region CRUD
  Future<void> create() async {
    emit(state.copyWith(statuses: CubitStatuses.loading, cubitCrud: CubitCrud.create));

    final response = await APIService().callApi(
      type: ApiType.post,
      url: PostUrl.create$nameServiceCC,
      body: state.cRequest.toJson(),
    );

    await _updateState(response);
  }

  Future<void> update() async {
    emit(state.copyWith(statuses: CubitStatuses.loading, cubitCrud: CubitCrud.update));

    final response = await APIService().callApi(
      type: ApiType.put,
      url: PutUrl.update$nameServiceCC,
      query: {'id': state.cRequest.id},
      body: state.cRequest.toJson(),
    );
    await _updateState(response);
  }

  Future<void> delete({required String id}) async {
    emit(state.copyWith(statuses: CubitStatuses.loading, cubitCrud: CubitCrud.delete, id: id));

    final response = await APIService().callApi(
      type: ApiType.delete,
      url: DeleteUrl.delete$nameServiceCC,
      query: {'id': state.id},
    );

    await _updateState(response, isDelete: true);
  }

  Future<void> deleteNow({required String id}) async {
    final index = state.result.indexWhere((element) => element.id == id);
    final item = state.result.removeAt(index);

    emit(state.copyWith(cubitCrud: CubitCrud.delete, result: state.result, id: id));

    final response = await APIService().callApi(
      type: ApiType.delete,
      url: DeleteUrl.delete$nameServiceCC,
      query: {'id': state.id},
    );

    if (response.statusCode.success) {
      await delete${nameServicePC}FromCache(item.id);
    } else {
      showErrorFromApi(state);
      state.result.insert(index, item);
      emit(state.copyWith(statuses: CubitStatuses.error, result: state.result));
    }
  }

  Future<void> _updateState(Response response, {bool isDelete = false}) async {
    if (response.statusCode.success) {
      final item = $nameServicePC.fromJson(response.jsonBody);
      isDelete ? await delete${nameServicePC}FromCache(state.id) : await addOrUpdate${nameServicePC}ToCache(item);
      emit(state.copyWith(statuses: CubitStatuses.done));
    } else {
      showErrorFromApi(state);
      emit(state.copyWith(statuses: CubitStatuses.error));
    }
  }

  //endregion

  Future<void> addOrUpdate${nameServicePC}ToCache($nameServicePC item) async {
    final listJson = await addOrUpdateDate([item]);
    if (listJson == null) return;
    final list = listJson.map((e) => $nameServicePC.fromJson(e)).toList();
    emit(state.copyWith(result: list));
  }

  Future<void> delete${nameServicePC}FromCache(String id) async {
    final listJson = await deleteDate([id]);
    if (listJson == null) return;
    final list = listJson.map((e) => $nameServicePC.fromJson(e)).toList();
    emit(state.copyWith(result: list));
  }
}

   ''';
