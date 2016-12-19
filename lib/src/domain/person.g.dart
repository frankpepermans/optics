// GENERATED CODE - DO NOT MODIFY BY HAND

part of domain.person;

// **************************************************************************
// Generator: OpticsGenerator
// Target: abstract class Person
// **************************************************************************

/**
 * The immutable implementation of [Person]
 */
class PersonImm implements Person {
  final String id;
  final String firstName;
  final String lastName;
  final Address address;
  final Iterable<Address> pastAddresses;
  PersonImm(
      this.address, this.firstName, this.id, this.lastName, this.pastAddresses);

  factory PersonImm.fromMap(Map<String, dynamic> source) => new PersonImm(
      source['address'] != null
          ? new AddressImm.fromMap(source['address'] is _AddressTemplate
              ? source['address']._mappify()
              : source['address'] is AddressImm
                  ? source['address'].toJson()
                  : source['address'])
          : null,
      source['firstName'],
      source['id'],
      source['lastName'],
      source['pastAddresses'] != null
          ? new UnmodifiableListView<Address>(
              source['pastAddresses'].toList(growable: false))
          : null);

  factory PersonImm.fromLens(void predicate(_PersonTemplate template)) {
    final _PersonTemplate template = new _PersonTemplate(null);
    predicate(template);
    return new PersonImm.fromMap(template._mutations);
  }

  PersonImm lens(void predicate(_PersonTemplate template)) {
    final _PersonTemplate template = new _PersonTemplate(this);
    predicate(template);
    return new PersonImm.fromMap(template._mutations);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'address': this.address,
        'firstName': this.firstName,
        'id': this.id,
        'lastName': this.lastName,
        'pastAddresses': this.pastAddresses
      };
}

/**
 * The mutable interface for [Person]
 */
abstract class PersonMut extends Person {
  String get id;
  set id(String value);

  String get firstName;
  set firstName(String value);

  String get lastName;
  set lastName(String value);

  AddressMut get address;
  set address(Address value);

  List<Address> get pastAddresses;
  set pastAddresses(Iterable<Address> value);
}

/**
 * The template implementation of [PersonMut]
 */
class _PersonTemplate implements PersonMut {
  final Person source;
  final Map<String, dynamic> _mutations = <String, dynamic>{};

  String get id => _mutations['id'];
  set id(String value) {
    _mutations['id'] = value;
  }

  String get firstName => _mutations['firstName'];
  set firstName(String value) {
    _mutations['firstName'] = value;
  }

  String get lastName => _mutations['lastName'];
  set lastName(String value) {
    _mutations['lastName'] = value;
  }

  AddressMut get address {
    if (_mutations['address'] == null)
      _mutations['address'] = new _AddressTemplate(null);
    return _mutations['address'];
  }

  set address(Address value) {
    _mutations['address'] = value;
  }

  List<Address> get pastAddresses {
    if (_mutations['pastAddresses'] == null)
      _mutations['pastAddresses'] = new List<Address>();
    return _mutations['pastAddresses'];
  }

  set pastAddresses(Iterable<Address> value) {
    _mutations['pastAddresses'] = value;
  }

  _PersonTemplate(this.source) {
    _mutations['address'] =
        source?.address != null ? new _AddressTemplate(source?.address) : null;
    _mutations['firstName'] = source?.firstName;
    _mutations['id'] = source?.id;
    _mutations['lastName'] = source?.lastName;
    _mutations['pastAddresses'] = source?.pastAddresses;
  }

  Map<String, dynamic> _mappify() => <String, dynamic>{
        'address': _mutations['address'],
        'firstName': _mutations['firstName'],
        'id': _mutations['id'],
        'lastName': _mutations['lastName'],
        'pastAddresses': _mutations['pastAddresses']
      };
}

// **************************************************************************
// Generator: OpticsGenerator
// Target: abstract class Address
// **************************************************************************

/**
 * The immutable implementation of [Address]
 */
class AddressImm implements Address {
  final String street;
  final String number;
  final String town;
  final String country;
  final Person landLord;
  AddressImm(this.country, this.landLord, this.number, this.street, this.town);

  factory AddressImm.fromMap(Map<String, dynamic> source) => new AddressImm(
      source['country'],
      source['landLord'] != null
          ? new PersonImm.fromMap(source['landLord'] is _PersonTemplate
              ? source['landLord']._mappify()
              : source['landLord'] is PersonImm
                  ? source['landLord'].toJson()
                  : source['landLord'])
          : null,
      source['number'],
      source['street'],
      source['town']);

  factory AddressImm.fromLens(void predicate(_AddressTemplate template)) {
    final _AddressTemplate template = new _AddressTemplate(null);
    predicate(template);
    return new AddressImm.fromMap(template._mutations);
  }

  AddressImm lens(void predicate(_AddressTemplate template)) {
    final _AddressTemplate template = new _AddressTemplate(this);
    predicate(template);
    return new AddressImm.fromMap(template._mutations);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'country': this.country,
        'landLord': this.landLord,
        'number': this.number,
        'street': this.street,
        'town': this.town
      };
}

/**
 * The mutable interface for [Address]
 */
abstract class AddressMut extends Address {
  String get street;
  set street(String value);

  String get number;
  set number(String value);

  String get town;
  set town(String value);

  String get country;
  set country(String value);

  PersonMut get landLord;
  set landLord(Person value);
}

/**
 * The template implementation of [AddressMut]
 */
class _AddressTemplate implements AddressMut {
  final Address source;
  final Map<String, dynamic> _mutations = <String, dynamic>{};

  String get street => _mutations['street'];
  set street(String value) {
    _mutations['street'] = value;
  }

  String get number => _mutations['number'];
  set number(String value) {
    _mutations['number'] = value;
  }

  String get town => _mutations['town'];
  set town(String value) {
    _mutations['town'] = value;
  }

  String get country => _mutations['country'];
  set country(String value) {
    _mutations['country'] = value;
  }

  PersonMut get landLord {
    if (_mutations['landLord'] == null)
      _mutations['landLord'] = new _PersonTemplate(null);
    return _mutations['landLord'];
  }

  set landLord(Person value) {
    _mutations['landLord'] = value;
  }

  _AddressTemplate(this.source) {
    _mutations['country'] = source?.country;
    _mutations['landLord'] =
        source?.landLord != null ? new _PersonTemplate(source?.landLord) : null;
    _mutations['number'] = source?.number;
    _mutations['street'] = source?.street;
    _mutations['town'] = source?.town;
  }

  Map<String, dynamic> _mappify() => <String, dynamic>{
        'country': _mutations['country'],
        'landLord': _mutations['landLord'],
        'number': _mutations['number'],
        'street': _mutations['street'],
        'town': _mutations['town']
      };
}
