import 'package:optics/optics.dart';

import 'address.dart';
import 'employee.dart';

@optics
abstract class Company extends Comparable<dynamic> {
  String get name;
  DateTime get founded;
  Address get address;
  Iterable<Employee> get employees;
}