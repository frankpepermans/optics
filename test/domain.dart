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
abstract class Employee {

  int get id;

  String get firstName;

  String get lastName;

  Address get address;

  Employee get reportsTo;
}

@optics
abstract class Address {

  String get street;

  String get number;

  String get town;

  String get country;
}