import '../../const_data.dart';

String get request =>
    '''
import '../response/${nameServiceSC}_response.dart';

class Create${nameServicePC}Request {
  Create${nameServicePC}Request({
    required this.id,
  });

  final String id;

  factory Create${nameServicePC}Request.fromJson(Map<String, dynamic> json) {
    return Create${nameServicePC}Request(
      id: json["id"] ?? "",
    );
  }

  factory Create${nameServicePC}Request.from$nameServicePC($nameServicePC $nameServiceCC) {
    return Create${nameServicePC}Request(
      id: $nameServiceCC.id.toString(),
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
      };
}

''';
