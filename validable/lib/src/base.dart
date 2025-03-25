///
abstract interface class Annotation {}

///
abstract class ValidationConstraintContext {}

///
abstract class ConstraintValidator<TAnnotation extends Annotation, T> {}

///
abstract interface class ValidationConstraint<T> {
  bool isValid(T value, ValidationConstraintContext context);
}
