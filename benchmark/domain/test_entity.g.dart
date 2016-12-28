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

/// All public properties for [TestEntity]
abstract class TestEntityProps {
  static const String name = 'name';

  static const String date = 'date';

  static const String cyclicReference = 'cyclicReference';
}

/// The immutable implementation of [TestEntity]
class TestEntityImmutable extends TestEntitySuperClassImmutable
    implements TestEntity {
  @override
  final String name;
  @override
  final DateTime date;
  @override
  final TestEntity cyclicReference;
  const TestEntityImmutable({this.cyclicReference, this.date, this.name});

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

  TestEntityImmutable lens(
      void predicate(TestEntityTemplate<TestEntity> template)) {
    final TestEntityTemplate<TestEntity> template =
        new TestEntityTemplate<TestEntity>(this);
    predicate(template);
    return new TestEntityImmutable.fromMap(template.mutations);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'cyclicReference': this.cyclicReference,
        'date': this.date,
        'name': this.name
      };
  @override
  int compareTo(dynamic other) {
    if (other is TestEntity) {
      return (compareObjects(cyclicReference, other?.cyclicReference) == 0 &&
              compareObjects(date, other?.date) == 0 &&
              compareObjects(name, other?.name) == 0)
          ? 0
          : 1;
    }
    return -1;
  }
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
  final T source;
  final Map<String, dynamic> mutations = <String, dynamic>{};

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

  TestEntityTemplate(this.source) {
    mutations['cyclicReference'] = source?.cyclicReference != null
        ? new TestEntityTemplate<TestEntity>(source.cyclicReference)
        : null;
    mutations['date'] = source?.date;
    mutations['name'] = source?.name;
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'cyclicReference': mutations['cyclicReference'],
        'date': mutations['date'],
        'name': mutations['name']
      };
}
