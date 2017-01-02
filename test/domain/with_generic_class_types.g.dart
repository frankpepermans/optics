// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// Generator: OpticsGenerator
// Target: abstract class WithGenericClassTypes
// **************************************************************************

import 'dart:collection';

import 'package:optics/optics.dart';

import 'with_generic_class_types.dart';

export 'with_generic_class_types.dart';

/// All public properties for [WithGenericClassTypes]
abstract class WithGenericClassTypesProps<A, B> {
  static const String a = 'a';

  static const String b = 'b';
}

/// The immutable implementation of [WithGenericClassTypes]
class WithGenericClassTypesImmutable<A, B>
    implements WithGenericClassTypes<A, B>, Comparable {
  @override
  final A a;
  @override
  final B b;
  const WithGenericClassTypesImmutable({this.a, this.b});

  factory WithGenericClassTypesImmutable.fromMap(Map<String, dynamic> source) {
    final A a = source['a'];
    final B b = source['b'];
    return new WithGenericClassTypesImmutable(a: a, b: b);
  }

  factory WithGenericClassTypesImmutable.fromLens(
      void predicate(
          WithGenericClassTypesTemplate<WithGenericClassTypes<A, B>, A,
              B> template)) {
    final WithGenericClassTypesTemplate<WithGenericClassTypes<A, B>, A, B>
        template =
        new WithGenericClassTypesTemplate<WithGenericClassTypes<A, B>, A, B>(
            null);
    predicate(template);
    return new WithGenericClassTypesImmutable.fromMap(template.mutations);
  }

  WithGenericClassTypesImmutable lens(
      void predicate(
          WithGenericClassTypesTemplate<WithGenericClassTypes<A, B>, A,
              B> template)) {
    final WithGenericClassTypesTemplate<WithGenericClassTypes<A, B>, A, B>
        template =
        new WithGenericClassTypesTemplate<WithGenericClassTypes<A, B>, A, B>(
            this);
    predicate(template);
    return new WithGenericClassTypesImmutable.fromMap(template.mutations);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{'a': this.a, 'b': this.b};
  @override
  int compareTo(dynamic other) {
    if (other is WithGenericClassTypes) {
      return (compareObjects(a, other?.a) == 0 &&
              compareObjects(b, other?.b) == 0)
          ? 0
          : 1;
    }
    return -1;
  }
}

/// The mutable interface for [WithGenericClassTypes]
abstract class WithGenericClassTypesMutable<A, B>
    extends WithGenericClassTypes<A, B> with Comparable {
  @override
  A get a;
  set a(A value);

  @override
  B get b;
  set b(B value);
}

/// The template implementation of [WithGenericClassTypesMutable]
class WithGenericClassTypesTemplate<T extends WithGenericClassTypes, A, B>
    implements WithGenericClassTypesMutable<A, B>, Comparable {
  final T source;
  final Map<String, dynamic> mutations = <String, dynamic>{};

  @override
  A get a => mutations['a'];
  @override
  set a(A value) {
    mutations['a'] = value;
  }

  @override
  B get b => mutations['b'];
  @override
  set b(B value) {
    mutations['b'] = value;
  }

  WithGenericClassTypesTemplate(this.source) {
    mutations['a'] = source?.a;
    mutations['b'] = source?.b;
  }

  Map<String, dynamic> toJson() =>
      <String, dynamic>{'a': mutations['a'], 'b': mutations['b']};
  @override
  int compareTo(dynamic other) => -1;
}
