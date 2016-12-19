// GENERATED CODE - DO NOT MODIFY BY HAND

part of domain.person;

// **************************************************************************
// Generator: OpticsGenerator
// Target: abstract class Company
// **************************************************************************

/**
 * The immutable implementation of [Company]
 */
class CompanyImm implements Company {
  final String name;
  final DateTime founded;
  final Address address;
  final Iterable<Employee> employees;
  CompanyImm(this.address, this.employees, this.founded, this.name);

  factory CompanyImm.fromMap(Map<String, dynamic> source) => new CompanyImm(
      source['address'] != null
          ? new AddressImm.fromMap(source['address'] is _AddressTemplate
              ? source['address']._mappify()
              : source['address'] is AddressImm
                  ? source['address'].toJson()
                  : source['address'])
          : null,
      source['employees'] != null
          ? new UnmodifiableListView<Employee>(
              source['employees'].toList(growable: false))
          : null,
      source['founded'],
      source['name']);

  factory CompanyImm.fromLens(void predicate(_CompanyTemplate template)) {
    final _CompanyTemplate template = new _CompanyTemplate(null);
    predicate(template);
    return new CompanyImm.fromMap(template._mutations);
  }

  CompanyImm lens(void predicate(_CompanyTemplate template)) {
    final _CompanyTemplate template = new _CompanyTemplate(this);
    predicate(template);
    return new CompanyImm.fromMap(template._mutations);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'address': this.address,
        'employees': this.employees,
        'founded': this.founded,
        'name': this.name
      };
}

/**
 * The mutable interface for [Company]
 */
abstract class CompanyMut extends Company {
  String get name;
  set name(String value);

  DateTime get founded;
  set founded(DateTime value);

  AddressMut get address;
  set address(Address value);

  List<Employee> get employees;
  set employees(Iterable<Employee> value);
}

/**
 * The template implementation of [CompanyMut]
 */
class _CompanyTemplate implements CompanyMut {
  final Company source;
  final Map<String, dynamic> _mutations = <String, dynamic>{};

  String get name => _mutations['name'];
  set name(String value) {
    _mutations['name'] = value;
  }

  DateTime get founded => _mutations['founded'];
  set founded(DateTime value) {
    _mutations['founded'] = value;
  }

  AddressMut get address {
    if (_mutations['address'] == null)
      _mutations['address'] = new _AddressTemplate(null);
    return _mutations['address'];
  }

  set address(Address value) {
    _mutations['address'] = value;
  }

  List<Employee> get employees {
    if (_mutations['employees'] == null) _mutations['employees'] = <Employee>[];
    if (_mutations['employees'].firstWhere(
            (Employee entry) => entry is! _EmployeeTemplate,
            orElse: () => null) !=
        null)
      _mutations['employees'] = _mutations['employees']
          .map((Employee entry) =>
              entry is _EmployeeTemplate ? entry : new _EmployeeTemplate(entry))
          .toList();
    return _mutations['employees'];
  }

  set employees(Iterable<Employee> value) {
    _mutations['employees'] = value;
  }

  _CompanyTemplate(this.source) {
    _mutations['address'] =
        source?.address != null ? new _AddressTemplate(source.address) : null;
    _mutations['employees'] = source?.employees != null
        ? new List<Employee>.from(source.employees
            .map((Employee entry) => new _EmployeeTemplate(entry)))
        : null;
    _mutations['founded'] = source?.founded;
    _mutations['name'] = source?.name;
  }

  Map<String, dynamic> _mappify() => <String, dynamic>{
        'address': _mutations['address'],
        'employees': _mutations['employees'],
        'founded': _mutations['founded'],
        'name': _mutations['name']
      };
}

// **************************************************************************
// Generator: OpticsGenerator
// Target: abstract class Employee
// **************************************************************************

/**
 * The immutable implementation of [Employee]
 */
class EmployeeImm implements Employee {
  final int id;
  final String firstName;
  final String lastName;
  final Address address;
  final Employee reportsTo;
  EmployeeImm(
      this.address, this.firstName, this.id, this.lastName, this.reportsTo);

  factory EmployeeImm.fromMap(Map<String, dynamic> source) => new EmployeeImm(
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
      source['reportsTo'] != null
          ? new EmployeeImm.fromMap(source['reportsTo'] is _EmployeeTemplate
              ? source['reportsTo']._mappify()
              : source['reportsTo'] is EmployeeImm
                  ? source['reportsTo'].toJson()
                  : source['reportsTo'])
          : null);

  factory EmployeeImm.fromLens(void predicate(_EmployeeTemplate template)) {
    final _EmployeeTemplate template = new _EmployeeTemplate(null);
    predicate(template);
    return new EmployeeImm.fromMap(template._mutations);
  }

  EmployeeImm lens(void predicate(_EmployeeTemplate template)) {
    final _EmployeeTemplate template = new _EmployeeTemplate(this);
    predicate(template);
    return new EmployeeImm.fromMap(template._mutations);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'address': this.address,
        'firstName': this.firstName,
        'id': this.id,
        'lastName': this.lastName,
        'reportsTo': this.reportsTo
      };
}

/**
 * The mutable interface for [Employee]
 */
abstract class EmployeeMut extends Employee {
  int get id;
  set id(int value);

  String get firstName;
  set firstName(String value);

  String get lastName;
  set lastName(String value);

  AddressMut get address;
  set address(Address value);

  EmployeeMut get reportsTo;
  set reportsTo(Employee value);
}

/**
 * The template implementation of [EmployeeMut]
 */
class _EmployeeTemplate implements EmployeeMut {
  final Employee source;
  final Map<String, dynamic> _mutations = <String, dynamic>{};

  int get id => _mutations['id'];
  set id(int value) {
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

  EmployeeMut get reportsTo {
    if (_mutations['reportsTo'] == null)
      _mutations['reportsTo'] = new _EmployeeTemplate(null);
    return _mutations['reportsTo'];
  }

  set reportsTo(Employee value) {
    _mutations['reportsTo'] = value;
  }

  _EmployeeTemplate(this.source) {
    _mutations['address'] =
        source?.address != null ? new _AddressTemplate(source.address) : null;
    _mutations['firstName'] = source?.firstName;
    _mutations['id'] = source?.id;
    _mutations['lastName'] = source?.lastName;
    _mutations['reportsTo'] = source?.reportsTo != null
        ? new _EmployeeTemplate(source.reportsTo)
        : null;
  }

  Map<String, dynamic> _mappify() => <String, dynamic>{
        'address': _mutations['address'],
        'firstName': _mutations['firstName'],
        'id': _mutations['id'],
        'lastName': _mutations['lastName'],
        'reportsTo': _mutations['reportsTo']
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
  AddressImm(this.country, this.number, this.street, this.town);

  factory AddressImm.fromMap(Map<String, dynamic> source) => new AddressImm(
      source['country'], source['number'], source['street'], source['town']);

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

  _AddressTemplate(this.source) {
    _mutations['country'] = source?.country;
    _mutations['number'] = source?.number;
    _mutations['street'] = source?.street;
    _mutations['town'] = source?.town;
  }

  Map<String, dynamic> _mappify() => <String, dynamic>{
        'country': _mutations['country'],
        'number': _mutations['number'],
        'street': _mutations['street'],
        'town': _mutations['town']
      };
}
