/// Animals.
enum Animal {
  dog(1),
  cat(2);

  const Animal(this.id);

  final int id;
}

/// Entities.
enum Entities {
  customer('cus'),
  product('pro');

  const Entities(this.code);

  final String code;
}

/// Classes.
enum Classes {
  customer('cus', 1),
  product('pro', 2);

  const Classes(this.code, this.id);

  final String code;
  final int id;
}
