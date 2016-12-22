import 'package:optics/optics.dart';

@optics
abstract class Address {

  String get street;

  String get number;

  String get town;

  String get country;
}