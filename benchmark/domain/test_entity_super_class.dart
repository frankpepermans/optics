import 'package:optics/optics.dart';

@optics
abstract class TestEntitySuperClass extends Comparable<dynamic> {
  int get id;
}