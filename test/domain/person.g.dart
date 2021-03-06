// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// Generator: OpticsGenerator
// Target: abstract class Person
// **************************************************************************

import 'dart:collection';

import 'package:optics/optics.dart';

import 'person.dart';

export 'person.dart';

/// All public properties for [Person]
abstract class PersonProps {
  static const String firstName = 'firstName';

  static const String lastName = 'lastName';
}

/// The immutable implementation of [Person]
class PersonImmutable implements Person, Comparable {
  @override
  final String firstName;
  @override
  final String lastName;
  const PersonImmutable({this.firstName, this.lastName});

  factory PersonImmutable.fromMap(Map<String, dynamic> source) {
    final String firstName = source['firstName'];
    final String lastName = source['lastName'];
    return new PersonImmutable(firstName: firstName, lastName: lastName);
  }

  factory PersonImmutable.fromLens(
      void predicate(PersonTemplate<Person> template)) {
    final PersonTemplate<Person> template = new PersonTemplate<Person>(null);
    predicate(template);
    return new PersonImmutable.fromMap(template.mutations);
  }

  PersonImmutable lens(void predicate(PersonTemplate<Person> template)) {
    final PersonTemplate<Person> template = new PersonTemplate<Person>(this);
    predicate(template);
    return new PersonImmutable.fromMap(template.mutations);
  }

  Map<String, dynamic> toJson() =>
      <String, dynamic>{'firstName': this.firstName, 'lastName': this.lastName};
  @override
  int compareTo(dynamic other) {
    if (other is Person) {
      return (compareObjects(firstName, other?.firstName) == 0 &&
              compareObjects(lastName, other?.lastName) == 0)
          ? 0
          : 1;
    }
    return -1;
  }
}

/// The mutable interface for [Person]
abstract class PersonMutable extends Person with Comparable {
  @override
  String get firstName;
  set firstName(String value);

  @override
  String get lastName;
  set lastName(String value);
}

/// The template implementation of [PersonMutable]
class PersonTemplate<T extends Person> implements PersonMutable, Comparable {
  final T source;
  final Map<String, dynamic> mutations = <String, dynamic>{};

  @override
  String get firstName => mutations['firstName'];
  @override
  set firstName(String value) {
    mutations['firstName'] = value;
  }

  @override
  String get lastName => mutations['lastName'];
  @override
  set lastName(String value) {
    mutations['lastName'] = value;
  }

  PersonTemplate(this.source) {
    mutations['firstName'] = source?.firstName;
    mutations['lastName'] = source?.lastName;
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'firstName': mutations['firstName'],
        'lastName': mutations['lastName']
      };
  @override
  int compareTo(dynamic other) => -1;
}
