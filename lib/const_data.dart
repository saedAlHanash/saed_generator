import 'package:saed_generator/extinctions.dart';

String rootFolder = '';
String nameService = '';
String apiName = '';
String nameProject = '';

String get nameServiceCC => nameService.toCamelCase;
String get nameServiceSC => nameService.toSnakeCase;
String get nameServicePC => nameService.toPascalCase;
