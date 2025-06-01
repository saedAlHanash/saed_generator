import '../../const_data.dart';

import '../../const_data.dart';

final itemState =
    '''
part of '${nameServiceSC}_cubit.dart';

class ${nameServicePC}Initial extends AbstractState<$nameServicePC> {
  const ${nameServicePC}Initial({
    required super.result,
    super.error,
    required super.request,
    super.statuses,
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
        if (filterRequest != null) filterRequest!,
      ];
      
  ${nameServicePC}Initial copyWith({
    CubitStatuses? statuses,
    $nameServicePC? result,
    String? error,
    String? request,
  }) {
    return ${nameServicePC}Initial(
      statuses: statuses ?? this.statuses,
      result: result ?? this.result,
      error: error ?? this.error,
      request: request ?? this.request,
    );
  }
}

   ''';
