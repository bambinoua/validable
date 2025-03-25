import 'package:flutter/foundation.dart' show immutable;

/// Object describes the constraint for field validation.
@immutable
class Constraint<T> {
  /// Creates a validable field constraint.
  const Constraint({
    this.isNull = true,
    this.min,
    this.max,
    this.list,
    this.regExp,
  }) : assert(regExp == null || regExp != '');

  /// Indicates whether the field cannot be omitted or its value cannot contains null.
  final bool isNull;

  /// The minimum value.
  ///
  /// For [int] values it is treated as smaller value, for [String] as minimum length.
  final num? min;

  /// For [int] values it is treated as greater value, for [String] as maximum length.
  final num? max;

  /// The list of valid values.
  final Iterable<T>? list;

  /// The regular expression to which the field value must match.
  final String? regExp;

  /// Indicates whether the field can be omitted or its value can contains null.
  bool get isNotNull => !isNull;

  /// Returns the data type of this constraint.
  Type get dataType => T;

  /// Indicates whether the minumum value is set.
  bool get hasMin => min != null;

  /// Indicates whether the maxumum value is set.
  bool get hasMax => max != null;

  /// Indicates whether this constraint has a list.
  bool get hasList => list != null;

  /// Indicates whether this constraint has a regular expression.
  bool get hasRegExp => regExp != null;

  @override
  String toString() {
    final props = {
      if (isNull) 'nullable': false,
      if (hasMin) 'min': min,
      if (hasMax) 'max': max,
      if (hasList) 'list': list,
      if (hasRegExp) 'regexp': regExp,
    };
    return 'Constraint $props';
  }
}

/// The mixin injects the [Constraint] into [Enum] which describes the list of
/// object constraints.
mixin ConstrainedEnumMixin on Enum {
  /// Constraint data for this field.
  Constraint get data;
}
