// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// Generator: OpticsGenerator
// Target: abstract class PersonWithAddress
// **************************************************************************

import 'dart:collection';

import 'package:optics/optics.dart';

import 'person_with_address.dart';
import 'address.g.dart';
import 'person.g.dart';

export 'person_with_address.dart';

/// The immutable implementation of [PersonWithAddress]
class PersonWithAddressImmutable extends PersonImmutable
    implements PersonWithAddress {
  @override
  final Address address;
  PersonWithAddressImmutable({this.address, String firstName, String lastName})
      : super(firstName: firstName, lastName: lastName);

  factory PersonWithAddressImmutable.fromMap(Map<String, dynamic> source) {
    final Address address = source['address'];
    final String firstName = source['firstName'];
    final String lastName = source['lastName'];
    return new PersonWithAddressImmutable(
        address: address != null
            ? new AddressImmutable.fromMap(address is AddressTemplate<Address>
                ? address.mappify()
                : address is AddressImmutable ? address.toJson() : const {})
            : null,
        firstName: firstName,
        lastName: lastName);
  }

  factory PersonWithAddressImmutable.fromLens(
      void predicate(PersonWithAddressTemplate<PersonWithAddress> template)) {
    final PersonWithAddressTemplate<PersonWithAddress> template =
        new PersonWithAddressTemplate<PersonWithAddress>(null);
    predicate(template);
    return new PersonWithAddressImmutable.fromMap(template.mutations);
  }

  @override
  PersonWithAddressImmutable lens(
      void predicate(PersonWithAddressTemplate<PersonWithAddress> template)) {
    final PersonWithAddressTemplate<PersonWithAddress> template =
        new PersonWithAddressTemplate<PersonWithAddress>(this);
    predicate(template);
    return new PersonWithAddressImmutable.fromMap(template.mutations);
  }

  @override
  Map<String, dynamic> toJson() =>
      super.toJson()..addAll(<String, dynamic>{'address': this.address});
}

/// The mutable interface for [PersonWithAddress]
abstract class PersonWithAddressMutable extends PersonWithAddress
    with PersonMutable {
  @override
  AddressMutable get address;
  set address(Address value);
}

/// The template implementation of [PersonWithAddressMutable]
class PersonWithAddressTemplate<T extends PersonWithAddress>
    extends PersonTemplate<T> implements PersonWithAddressMutable {
  @override
  AddressMutable get address {
    if (mutations['address'] == null)
      mutations['address'] = new AddressTemplate<Address>(null);
    return mutations['address'];
  }

  @override
  set address(Address value) {
    mutations['address'] = value;
  }

  PersonWithAddressTemplate(T source) : super(source) {
    mutations['address'] = source?.address != null
        ? new AddressTemplate<Address>(source.address)
        : null;
  }

  @override
  Map<String, dynamic> mappify() => super.mappify()
    ..addAll(<String, dynamic>{'address': mutations['address']});
}
