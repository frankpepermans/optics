// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// Generator: OpticsGenerator
// Target: abstract class TestEntity
// **************************************************************************

import 'dart:collection';

import 'package:optics/optics.dart';

import 'test_entity.dart';
import 'test_entity_super_class.g.dart';

export 'test_entity.dart';

/// The immutable implementation of [TestEntity]
class TestEntityImmutable extends TestEntitySuperClassImmutable
    implements TestEntity {
  @override
  final String name;
  @override
  final DateTime date;
  @override
  final TestEntity cyclicReference;
  TestEntityImmutable({this.cyclicReference, this.date, this.name, int id})
      : super(id: id);

  factory TestEntityImmutable.fromMap(Map<String, dynamic> source) {
    final TestEntity cyclicReference = source['cyclicReference'];
    final DateTime date = source['date'];
    final String name = source['name'];
    final int id = source['id'];
    return new TestEntityImmutable(
        cyclicReference: cyclicReference != null
            ? new TestEntityImmutable.fromMap(
                cyclicReference is TestEntityTemplate<TestEntity>
                    ? cyclicReference.toJson()
                    : cyclicReference is TestEntityImmutable
                        ? cyclicReference.toJson()
                        : const {})
            : null,
        date: date,
        name: name,
        id: id);
  }

  factory TestEntityImmutable.fromLens(
      void predicate(TestEntityTemplate<TestEntity> template)) {
    final TestEntityTemplate<TestEntity> template =
        new TestEntityTemplate<TestEntity>(null);
    predicate(template);
    return new TestEntityImmutable.fromMap(template.mutations);
  }

  @override
  TestEntityImmutable lens(
      void predicate(TestEntityTemplate<TestEntity> template)) {
    final TestEntityTemplate<TestEntity> template =
        new TestEntityTemplate<TestEntity>(this);
    predicate(template);
    return new TestEntityImmutable.fromMap(template.mutations);
  }

  @override
  Map<String, dynamic> toJson() => super.toJson()
    ..addAll(<String, dynamic>{
      'cyclicReference': this.cyclicReference,
      'date': this.date,
      'name': this.name
    });
}

/// The mutable interface for [TestEntity]
abstract class TestEntityMutable extends TestEntity
    with TestEntitySuperClassMutable {
  @override
  String get name;
  set name(String value);

  @override
  DateTime get date;
  set date(DateTime value);

  @override
  TestEntityMutable get cyclicReference;
  set cyclicReference(TestEntity value);
}

/// The template implementation of [TestEntityMutable]
class TestEntityTemplate<T extends TestEntity>
    extends TestEntitySuperClassTemplate<T> implements TestEntityMutable {
  @override
  String get name => mutations['name'];
  @override
  set name(String value) {
    mutations['name'] = value;
  }

  @override
  DateTime get date => mutations['date'];
  @override
  set date(DateTime value) {
    mutations['date'] = value;
  }

  @override
  TestEntityMutable get cyclicReference {
    if (mutations['cyclicReference'] == null)
      mutations['cyclicReference'] = new TestEntityTemplate<TestEntity>(null);
    return mutations['cyclicReference'];
  }

  @override
  set cyclicReference(TestEntity value) {
    mutations['cyclicReference'] = value;
  }

  TestEntityTemplate(T source) : super(source) {
    mutations['cyclicReference'] = source?.cyclicReference != null
        ? new TestEntityTemplate<TestEntity>(source.cyclicReference)
        : null;
    mutations['date'] = source?.date;
    mutations['name'] = source?.name;
  }

  @override
  Map<String, dynamic> toJson() => super.toJson()
    ..addAll(<String, dynamic>{
      'cyclicReference': mutations['cyclicReference'],
      'date': mutations['date'],
      'name': mutations['name']
    });
}
