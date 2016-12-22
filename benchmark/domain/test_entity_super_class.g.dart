// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// Generator: OpticsGenerator
// Target: abstract class TestEntitySuperClass
// **************************************************************************

import 'dart:collection';

import 'package:optics/optics.dart';

import 'test_entity_super_class.dart';

export 'test_entity_super_class.dart';

/// The immutable implementation of [TestEntitySuperClass]
class TestEntitySuperClassImmutable implements TestEntitySuperClass {
  @override
  final int id;
  TestEntitySuperClassImmutable({this.id});

  factory TestEntitySuperClassImmutable.fromMap(Map<String, dynamic> source) {
    final int id = source['id'];
    return new TestEntitySuperClassImmutable(id: id);
  }

  factory TestEntitySuperClassImmutable.fromLens(
      void predicate(
          TestEntitySuperClassTemplate<TestEntitySuperClass> template)) {
    final TestEntitySuperClassTemplate<TestEntitySuperClass> template =
        new TestEntitySuperClassTemplate<TestEntitySuperClass>(null);
    predicate(template);
    return new TestEntitySuperClassImmutable.fromMap(template.mutations);
  }

  TestEntitySuperClassImmutable lens(
      void predicate(
          TestEntitySuperClassTemplate<TestEntitySuperClass> template)) {
    final TestEntitySuperClassTemplate<TestEntitySuperClass> template =
        new TestEntitySuperClassTemplate<TestEntitySuperClass>(this);
    predicate(template);
    return new TestEntitySuperClassImmutable.fromMap(template.mutations);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{'id': this.id};
}

/// The mutable interface for [TestEntitySuperClass]
abstract class TestEntitySuperClassMutable extends TestEntitySuperClass {
  @override
  int get id;
  set id(int value);
}

/// The template implementation of [TestEntitySuperClassMutable]
class TestEntitySuperClassTemplate<T extends TestEntitySuperClass>
    implements TestEntitySuperClassMutable {
  final T source;
  final Map<String, dynamic> mutations = <String, dynamic>{};

  @override
  int get id => mutations['id'];
  @override
  set id(int value) {
    mutations['id'] = value;
  }

  TestEntitySuperClassTemplate(this.source) {
    mutations['id'] = source?.id;
  }

  Map<String, dynamic> toJson() => <String, dynamic>{'id': mutations['id']};
}
