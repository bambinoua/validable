import 'dart:async';
import 'dart:convert';

import 'package:analyzer/dart/constant/value.dart';
import 'package:build/build.dart';

final _fieldPattern = RegExp(
  r'^(?<name>\w+)\s=\s(?<type>[^\s]+)\s\((?<value>[^\)]+)\)$',
  multiLine: true,
);

class EnumExtractBuilder implements Builder {
  @override
  final buildExtensions = const {
    '.dart': ['.enum_extract.json']
  };

  @override
  Future<void> build(BuildStep buildStep) async {
    final libraryElement = await buildStep.inputLibrary;
    log.shout('elen: ${libraryElement.source.fullName}');
    //final importedLibraries = libraryElement.importedLibraries.map((lib) => lib.name);
    final enumElements =
        libraryElement.units.expand((element) => element.enums).toList();

    if (enumElements.isEmpty) {
      return;
    }

    final enumsData = <Map<String, dynamic>>[];

    for (var enumElement in enumElements) {
      final enumMap = <String, dynamic>{
        'name': enumElement.name,
        'path': enumElement.source.uri.toString(),
        'comment': enumElement.documentationComment,
      };

      final enumMembers = [];

      final enumConstants =
          enumElement.fields.where((f) => f.isEnumConstant).toList();
      for (var fieldElement in enumConstants) {
        final DartObject constantValue = fieldElement.computeConstantValue()!;
        // Remove enum name from value string.
        String constantValueString = constantValue
            .toString()
            .replaceFirst(enumElement.name, '')
            .trimLeft();
        // Remove surrounding brackets.
        constantValueString =
            constantValueString.substring(1, constantValueString.length - 1);
        // Remove internal `_name` property.
        final sanitizedConstantValue = constantValueString
            .split(';')
            .map((lexem) => lexem.trim())
            .skip(1)
            .join('\n');

        final memberProps = [];

        for (var match in _fieldPattern.allMatches(sanitizedConstantValue)) {
          memberProps.add({
            'name': match.namedGroup('name'),
            'type': match.namedGroup('type'),
            'value': match.namedGroup('value'),
          });
        }

        enumMembers.add({
          'name': fieldElement.name,
          'meta': constantValueString,
          'properties': memberProps,
        });
      }

      enumMap['members'] = enumMembers;
      enumsData.add(enumMap);
    }

    final AssetId outputId =
        buildStep.inputId.changeExtension('.enum_extract.json');
    await buildStep.writeAsString(outputId, json.encode(enumsData));
  }
}
