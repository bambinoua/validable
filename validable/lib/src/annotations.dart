import 'package:meta/meta_meta.dart';

import 'enums.dart';

/// https://docs.oracle.com/javaee/7/api/javax/validation/constraints/package-summary.html

@Target({TargetKind.classType})
final class ConstraintRepository {
  const ConstraintRepository();
}

const constraintRepository = ConstraintRepository();

/// Marks a class as an validable entity and generates.
@Target({TargetKind.classType})
final class Validable {
  const Validable();
}

/// Const instance of [Validable].
const validable = Validable();

///
@Target({TargetKind.field, TargetKind.getter})
final class NotNull {
  const NotNull();
}

/// Const instance of [NotNull].
const notNull = NotNull();

///
@Target({TargetKind.field, TargetKind.getter})
final class Min<T extends num> {
  const Min(this.value);

  final T value;
}

///
@Target({TargetKind.field, TargetKind.getter})
final class Max<T extends num> {
  const Max(this.value);

  final T value;
}

///
@Target({TargetKind.field, TargetKind.getter})
final class Range<T extends num> {
  const Range(this.min, this.max);

  final T min;
  final T max;
}

///
@Target({TargetKind.field, TargetKind.getter})
final class Size {
  const Size({this.min, this.max});

  final int? min;
  final int? max;
}

///
@Target({TargetKind.field, TargetKind.getter})
final class Pattern {
  const Pattern(this.value) : assert(value != '');

  final String value;
}

///
@Target({TargetKind.field, TargetKind.getter})
final class Enumeration {
  const Enumeration(this.prop);

  final EnumProp prop;
}

const enumeration = Enumeration(EnumProp.indx);

///
@Target({TargetKind.field, TargetKind.getter})
final class Digits {
  const Digits({required this.integer, this.fraction = 0, this.message});

  final int integer;
  final int fraction;
  final String? message;
}

///
@Target({TargetKind.field, TargetKind.getter})
final class Email {
  const Email();
}

///
@Target({TargetKind.field, TargetKind.getter})
final class InList<T> {
  const InList(this.values) : assert(values.length != 0);

  final List<T> values;
}
