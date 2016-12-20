library domain.person;

import 'dart:collection';

import 'package:optics/optics.dart';

part 'domain.g.dart';

@optics
abstract class Company {

  String get name;

  DateTime get founded;

  Address get address;

  Iterable<Employee> get employees;
}

@optics
abstract class Person {

  String get firstName;

  String get lastName;
}

@optics
abstract class PersonWithAddress extends Person {

  Address get address;
}

@optics
abstract class Employee extends PersonWithAddress {

  int get id;

  Employee get reportsTo;
}

@optics
abstract class Address {

  String get street;

  String get number;

  String get town;

  String get country;
}