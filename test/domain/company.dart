import 'package:optics/optics.dart';

import 'address.dart';
import 'employee.dart';

@optics
abstract class Company {

  String get name;

  DateTime get founded;

  Address get address;

  Iterable<Employee> get employees;
}