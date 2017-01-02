import 'package:optics/optics.dart';

import 'person_with_address.dart';

@optics
abstract class Employee extends PersonWithAddress {
  int get id;
  Employee get reportsTo;
}