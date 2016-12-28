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

/// All public properties for [PersonWithAddress]
abstract class PersonWithAddressProps {
  static const String address = 'address';
}

/// The immutable implementation of [PersonWithAddress]
class PersonWithAddressImmutable extends PersonImmutable
    implements PersonWithAddress {
  @override
  final Address address;
  const PersonWithAddressImmutable({this.address});

  factory PersonWithAddressImmutable.fromMap(Map<String, dynamic> source) {
    final Address address = source['address'];
    final String firstName = source['firstName'];
    final String lastName = source['lastName'];
    return new PersonWithAddressImmutable(
        address: address != null
            ? new AddressImmutable.fromMap(address is AddressTemplate<Address>
                ? address.toJson()
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

  PersonWithAddressImmutable lens(
      void predicate(PersonWithAddressTemplate<PersonWithAddress> template)) {
    final PersonWithAddressTemplate<PersonWithAddress> template =
        new PersonWithAddressTemplate<PersonWithAddress>(this);
    predicate(template);
    return new PersonWithAddressImmutable.fromMap(template.mutations);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{'address': this.address};
  @override
  int compareTo(dynamic other) {
    if (other is PersonWithAddress) {
      return (compareObjects(address, other?.address) == 0) ? 0 : 1;
    }
    return -1;
  }
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
  final T source;
  final Map<String, dynamic> mutations = <String, dynamic>{};

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

  PersonWithAddressTemplate(this.source) {
    mutations['address'] = source?.address != null
        ? new AddressTemplate<Address>(source.address)
        : null;
  }

  Map<String, dynamic> toJson() =>
      <String, dynamic>{'address': mutations['address']};
}
