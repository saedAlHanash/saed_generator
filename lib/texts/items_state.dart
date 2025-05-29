import '../const_data.dart';

final itemsState =
    '''
part of '${nameServiceSC}s_cubit.dart';

class ${nameServicePC}sInitial extends AbstractState<List<$nameServicePC>> {
  const ${nameServicePC}sInitial({
    required super.result,
    super.error,
    super.request,
    super.filterRequest,
    super.cubitCrud,
    super.createUpdateRequest,
    super.statuses,
    super.id,
  });

  factory ${nameServicePC}sInitial.initial() {
    return const ${nameServicePC}sInitial(
      result: [],
    );
  }

  Create${nameServicePC}Request get cRequest => createUpdateRequest;

  String get mId => id;

  @override
  List<Object> get props => [
        statuses,
        result,
        error,
        cubitCrud,
        if (id != null) id,
        if (request != null) request,
        if (filterRequest != null) filterRequest!,
        if (createUpdateRequest != null) createUpdateRequest!,
      ];

  ${nameServicePC}sInitial copyWith({
    CubitStatuses? statuses,
    CubitCrud? cubitCrud,
    List<$nameServicePC>? result,
    String? error,
    FilterRequest? filterRequest,
    dynamic request,
    dynamic cRequest,
    dynamic id,
  }) {
    return ${nameServicePC}sInitial(
      statuses: statuses ?? this.statuses,
      cubitCrud: cubitCrud ?? this.cubitCrud,
      result: result ?? this.result,
      error: error ?? this.error,
      filterRequest: filterRequest ?? this.filterRequest,
      request: request ?? this.request,
      createUpdateRequest: cRequest ?? this.cRequest,
      id: id ?? this.id,
    );
  }
}

''';
