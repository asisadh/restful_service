import 'dart:io';

String stub({
  required String path,
  required String name,
}) {
  var dir = Directory.current.path;
  if (dir.endsWith('/test')) {
    dir = dir.replaceAll('/test', '');
  }
  return File('$dir/test/stub/$path/$name.json').readAsStringSync();
}
