import 'package:optics/optics.dart';

import 'test_entity_super_class.dart';

@optics
abstract class TestEntity extends TestEntitySuperClass {
  String get name;
  DateTime get date;
  TestEntity get cyclicReference;
}