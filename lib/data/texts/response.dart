import '../../const_data.dart';

final response =
    '''
class $nameServicePC {
  $nameServicePC({
    required this.id,
  });

  final String id;

  Map<String, dynamic> toJson() {
    return {
      "id": id,
    };
  }

  factory $nameServicePC.fromJson(Map<String, dynamic> json) {
    return $nameServicePC(
      id: json["id"] ?? "",
    );
  }

//</editor-fold>
}

class ${nameServicePC}s {
  final List<$nameServicePC> items;

  const ${nameServicePC}s({
    required this.items,
  });

  Map<String, dynamic> toJson() {
    return {
      'items': items,
    };
  }

  factory ${nameServicePC}s.fromJson(Map<String, dynamic> json) {
    return ${nameServicePC}s(
      items: json['items'] as List<$nameServicePC>,
    );
  }
}

''';
