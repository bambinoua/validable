import '../../annotations.dart';

@validable
class PaymentDTO {
  PaymentDTO({
    required this.id,
    required this.amount,
    required this.order,
    this.provider = PaymentType.cash,
    this.completed = false,
  });

  @notNull
  final int id;

  final int order;

  final num amount;

  @InList(PaymentType.values)
  final PaymentType provider;

  final bool completed;
}

/// Payment type.
enum PaymentType {
  cash,
  card;
}
