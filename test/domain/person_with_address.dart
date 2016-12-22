import 'package:optics/optics.dart';

import 'address.dart';
import 'person.dart';

@optics
abstract class PersonWithAddress extends Person {

  Address get address;
}