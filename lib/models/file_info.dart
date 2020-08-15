import 'package:ezkit/ezkit.dart';

class FileInfo {
  String path;
  String name;
  List<int> content;

  FileInfo(name, {String path, List<int> content});
}
