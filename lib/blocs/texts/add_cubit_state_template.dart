import '../../const_data.dart';

String addCubitStateTemplate({
  required String cubitNameSC,
  required String cubitNamePC,
  required String cubitNameCC,
}) =>
    '''
part of '${cubitNameSC}_cubit.dart';

class ${cubitNamePC}Initial extends AbstractState<$cubitNamePC> {
  const ${cubitNamePC}Initial({
    required super.result,
    super.error,
    required super.request,
    super.statuses,
    super.id,
  });

  factory ${cubitNamePC}Initial.initial() {
    return ${cubitNamePC}Initial(
      result: $cubitNamePC.fromJson({}),
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

 ${cubitNamePC}Initial copyWith({
    CubitStatuses? statuses,
   $cubitNamePC? result,
    String? error,
    dynamic id,
    String? request,
  }) {
    return ${cubitNamePC}Initial(
      statuses: statuses ?? this.statuses,
      result: result ?? this.result,
      error: error ?? this.error,
      id: id ?? this.id,
      request: request ?? this.request,
    );
  }
}
''';
