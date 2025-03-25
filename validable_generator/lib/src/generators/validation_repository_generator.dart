import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/visitor.dart';
import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';
import 'package:validable/annotations.dart';

class ValidationRepositoryGenerator
    extends GeneratorForAnnotation<ConstraintRepository> {
  @override
  dynamic generateForAnnotatedElement(
      Element element, ConstantReader annotation, BuildStep buildStep) {
    return 'Annotation ConstraintRepository found';
  }
}

class AnnotationVisitor extends SimpleElementVisitor {}
