// ignore_for_file: unused_element

import 'dart:async';

import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';
import 'package:validable/annotations.dart';

const _classTypeCheckers = {
  Validable: TypeChecker.fromRuntime(Validable),
  ConstraintRepository: TypeChecker.fromRuntime(ConstraintRepository),
};

const _fieldTypeCheckers = {
  NotNull: TypeChecker.fromRuntime(NotNull),
  Min: TypeChecker.fromRuntime(Min),
  Max: TypeChecker.fromRuntime(Max),
  Range: TypeChecker.fromRuntime(Range),
  Size: TypeChecker.fromRuntime(Size),
  Pattern: TypeChecker.fromRuntime(Pattern),
  Enumeration: TypeChecker.fromRuntime(Enumeration),
  Digits: TypeChecker.fromRuntime(Digits),
  Email: TypeChecker.fromRuntime(Email),
  InList: TypeChecker.fromRuntime(InList),
};

/// Whether [fieldElement] has any of validable annotations.
bool _hasAnnotation(FieldElement fieldElement) {
  return _fieldTypeCheckers.values
      .any((typeChecker) => typeChecker.hasAnnotationOfExact(fieldElement));
}

/// Whether [fieldElement] has a validable annotations of type T.
bool _hasExactAnnotation<T extends Type>(FieldElement fieldElement) {
  return _fieldTypeCheckers[T]!.hasAnnotationOfExact(fieldElement);
}

class ValidationConstraintGenerator extends Generator {
  ValidationConstraintGenerator() {
    log.warning('create ValidationConstraintGenerator');
  }

  @override
  FutureOr<String?> generate(LibraryReader library, BuildStep buildStep) {
    final classElements = <ClassElement, List<FieldElement>>{};

    for (final libraryClass in library.classes) {
      if (_classTypeCheckers[Validable]!.hasAnnotationOfExact(libraryClass)) {
        classElements.putIfAbsent(libraryClass, () => <FieldElement>[]);
      }
    }

    if (classElements.isEmpty) {
      return null;
    }

    // final test = buildStep.allowedOutputs.toList();
    // final test1 = await buildStep.inputLibrary;
    // final test2 = await buildStep.packageConfig;

    for (var enumElement in library.enums) {
      log.fine('${enumElement.name}: ${library.pathToElement(enumElement)}');
    }

    for (final classElement in classElements.keys) {
      final fieldElements = classElements[classElement]!;
      for (final fieldElement in classElement.fields) {
        if (_hasAnnotation(fieldElement)) {
          fieldElements.add(fieldElement);
        }
      }
    }

    final enumBuffer = StringBuffer();
    for (var entry in classElements.entries) {
      final classElement = entry.key;
      final memberBuffer = <String>[];
      for (var fieldElement in entry.value) {
        final dartType =
            fieldElement.type.getDisplayString().replaceFirst('?', '');
        memberBuffer.add('${fieldElement.name}(Constraint<$dartType>())');
      }
      final path = library.pathToElement(classElement).toString();
      final content =
          _enumPattern(classElement.name, path, memberBuffer.join(',\n'));
      enumBuffer.writeln(content);
    }

    return enumBuffer.toString();
  }
}

String _enumPattern(String name, String path, String fields) => '''
import 'package:validable/validable.dart';

/// Validation constraints
/// 
/// $path
enum ${name}Constraints with ConstrainedEnumMixin {
  $fields;

  const $name(this.data);

  @override
  final Constraint data;
}
''';
