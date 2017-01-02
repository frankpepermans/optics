import 'package:optics/optics.dart';

@optics
abstract class Person extends Comparable<dynamic> {
  String get firstName;
  String get lastName;
}