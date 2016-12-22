import 'package:optics/optics.dart';

@optics
abstract class Person {

  String get firstName;

  String get lastName;
}