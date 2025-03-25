import 'dart:typed_data';

import '../../annotations.dart';

@validable
class CustomerDTO {
  const CustomerDTO({
    this.id,
    this.firstName,
    this.lastName,
    this.gender,
    this.phoneNumber,
    this.birthDate,
    this.photo,
    this.debt,
    this.note,
    this.allowNotifications,
  });

  @notNull
  @Min(1)
  final int? id;

  @Size(min: 3, max: 15)
  final String? firstName;

  @Size(min: 3, max: 15)
  final String? lastName;

  @enumeration
  final Gender? gender;

  final String? phoneNumber;

  final DateTime? birthDate;

  final Uint8List? photo;

  @Min(0.0)
  final num? debt;

  final String? note;

  final bool? allowNotifications;
}

enum Gender { male, female }
