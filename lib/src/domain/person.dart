library domain.person;

import 'package:optics/src/metadata.dart';

part 'person.g.dart';

@optics
abstract class Person {

  String get id;

  String get firstName;

  String get lastName;

  Address get address;

  Iterable<Address> get pastAddresses;
}

@optics
abstract class Address {

  String get street;

  String get number;

  String get town;

  String get country;

  Person get landLord;
}