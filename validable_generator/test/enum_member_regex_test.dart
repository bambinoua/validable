import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final fieldPattern = RegExp(
    r'^(?<name>\w+)\s=\s(?<type>[^\s]+)\s\((?<value>[^\)]+)\)$',
    multiLine: true,
  );

  test('description', () {
    final data = "_name = String ('card')\nindex = int (1)";
    final match = fieldPattern.allMatches(data);
    if (kDebugMode) {
      print(match);
    }
  });
}
