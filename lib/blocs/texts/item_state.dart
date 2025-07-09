import '../../const_data.dart';

import '../../const_data.dart';

String get itemState =>
    '''
part of '${nameServiceSC}_cubit.dart';

class ${nameServicePC}Initial extends AbstractState<$nameServicePC> {
  const ${nameServicePC}Initial({
    required super.result,
    super.error,
    required super.request,
    super.statuses,
    super.id,
  });

  factory ${nameServicePC}Initial.initial() {
    return ${nameServicePC}Initial(
      result: $nameServicePC.fromJson({}),
      request: '',
      
    );
  }

  @override
  List<Object> get props => [
        statuses,
        result,
        error,
        if (request != null) request,
        if (id != null) id,
        if (filterRequest != null) filterRequest!,
      ];
      
  ${nameServicePC}Initial copyWith({
    CubitStatuses? statuses,
    $nameServicePC? result,
    String? error,
    dynamic id,
    String? request,
  }) {
    return ${nameServicePC}Initial(
      statuses: statuses ?? this.statuses,
      result: result ?? this.result,
      error: error ?? this.error,
      id: id ?? this.id,
      request: request ?? this.request,
    );
  }
}

   ''';
