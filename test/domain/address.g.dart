// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// Generator: OpticsGenerator
// Target: abstract class Address
// **************************************************************************

import 'dart:collection';

import 'package:optics/optics.dart';

import 'address.dart';

export 'address.dart';

/// All public properties for [Address]
abstract class AddressProps {
  static const String street = 'street';

  static const String number = 'number';

  static const String town = 'town';

  static const String country = 'country';
}

/// The immutable implementation of [Address]
class AddressImmutable implements Address {
  @override
  final String street;
  @override
  final String number;
  @override
  final String town;
  @override
  final String country;
  AddressImmutable({this.country, this.number, this.street, this.town});

  factory AddressImmutable.fromMap(Map<String, dynamic> source) {
    final String country = source['country'];
    final String number = source['number'];
    final String street = source['street'];
    final String town = source['town'];
    return new AddressImmutable(
        country: country, number: number, street: street, town: town);
  }

  factory AddressImmutable.fromLens(
      void predicate(AddressTemplate<Address> template)) {
    final AddressTemplate<Address> template =
        new AddressTemplate<Address>(null);
    predicate(template);
    return new AddressImmutable.fromMap(template.mutations);
  }

  AddressImmutable lens(void predicate(AddressTemplate<Address> template)) {
    final AddressTemplate<Address> template =
        new AddressTemplate<Address>(this);
    predicate(template);
    return new AddressImmutable.fromMap(template.mutations);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'country': this.country,
        'number': this.number,
        'street': this.street,
        'town': this.town
      };
}

/// The mutable interface for [Address]
abstract class AddressMutable extends Address {
  @override
  String get street;
  set street(String value);

  @override
  String get number;
  set number(String value);

  @override
  String get town;
  set town(String value);

  @override
  String get country;
  set country(String value);
}

/// The template implementation of [AddressMutable]
class AddressTemplate<T extends Address> implements AddressMutable {
  final T source;
  final Map<String, dynamic> mutations = <String, dynamic>{};

  @override
  String get street => mutations['street'];
  @override
  set street(String value) {
    mutations['street'] = value;
  }

  @override
  String get number => mutations['number'];
  @override
  set number(String value) {
    mutations['number'] = value;
  }

  @override
  String get town => mutations['town'];
  @override
  set town(String value) {
    mutations['town'] = value;
  }

  @override
  String get country => mutations['country'];
  @override
  set country(String value) {
    mutations['country'] = value;
  }

  AddressTemplate(this.source) {
    mutations['country'] = source?.country;
    mutations['number'] = source?.number;
    mutations['street'] = source?.street;
    mutations['town'] = source?.town;
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'country': mutations['country'],
        'number': mutations['number'],
        'street': mutations['street'],
        'town': mutations['town']
      };
}
