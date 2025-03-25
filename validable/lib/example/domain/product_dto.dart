import '../../annotations.dart';

@validable
class ProductDTO {
  ProductDTO({
    this.id,
    required this.title,
    this.price = 0,
  }) : assert(title.isNotEmpty);

  @notNull
  final int? id;

  @notNull
  final String title;

  @Min(0.0)
  final int price;
}
