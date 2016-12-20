// GENERATED CODE - DO NOT MODIFY BY HAND

part of domain.person;

// **************************************************************************
// Generator: OpticsGenerator
// Target: abstract class Company
// **************************************************************************

/// The immutable implementation of [Company]
class CompanyImm implements Company {
  @override
  final String name;
  @override
  final DateTime founded;
  @override
  final Address address;
  @override
  final Iterable<Employee> employees;
  CompanyImm({this.address, this.employees, this.founded, this.name});

  factory CompanyImm.fromMap(Map<String, dynamic> source) => new CompanyImm(
      address: source['address'] != null
          ? new AddressImm.fromMap(
              source['address'] is _AddressTemplate<Address>
                  ? source['address']._mappify()
                  : source['address'] is AddressImm
                      ? source['address'].toJson()
                      : source['address'])
          : null,
      employees: source['employees'] != null
          ? new UnmodifiableListView<Employee>(source['employees'].map(
              (Employee entry) => entry is _EmployeeTemplate<Employee>
                  ? new EmployeeImm.fromMap(entry._mutations)
                  : entry))
          : null,
      founded: source['founded'],
      name: source['name']);

  factory CompanyImm.fromLens(
      void predicate(_CompanyTemplate<Company> template)) {
    final _CompanyTemplate<Company> template =
        new _CompanyTemplate<Company>(null);
    predicate(template);
    return new CompanyImm.fromMap(template._mutations);
  }

  CompanyImm lens(void predicate(_CompanyTemplate<Company> template)) {
    final _CompanyTemplate<Company> template =
        new _CompanyTemplate<Company>(this);
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

/// The mutable interface for [Company]
abstract class CompanyMut extends Company {
  @override
  String get name;
  set name(String value);

  @override
  DateTime get founded;
  set founded(DateTime value);

  @override
  AddressMut get address;
  set address(Address value);

  @override
  List<Employee> get employees;
  set employees(Iterable<Employee> value);
}

/// The template implementation of [CompanyMut]
class _CompanyTemplate<T extends Company> implements CompanyMut {
  final T source;
  final Map<String, dynamic> _mutations = <String, dynamic>{};

  @override
  String get name => _mutations['name'];
  @override
  set name(String value) {
    _mutations['name'] = value;
  }

  @override
  DateTime get founded => _mutations['founded'];
  @override
  set founded(DateTime value) {
    _mutations['founded'] = value;
  }

  @override
  AddressMut get address {
    if (_mutations['address'] == null)
      _mutations['address'] = new _AddressTemplate<Address>(null);
    return _mutations['address'];
  }

  @override
  set address(Address value) {
    _mutations['address'] = value;
  }

  @override
  List<Employee> get employees {
    if (_mutations['employees'] == null) _mutations['employees'] = <Employee>[];
    if (_mutations['employees'].firstWhere(
            (Employee entry) => entry is! _EmployeeTemplate<Employee>,
            orElse: () => null) !=
        null)
      _mutations['employees'] = _mutations['employees']
          .map((Employee entry) => entry is _EmployeeTemplate<Employee>
              ? entry
              : new _EmployeeTemplate<Employee>(entry))
          .toList();
    return _mutations['employees'];
  }

  @override
  set employees(Iterable<Employee> value) {
    _mutations['employees'] = value;
  }

  _CompanyTemplate(this.source) {
    _mutations['address'] = source?.address != null
        ? new _AddressTemplate<Address>(source.address)
        : null;
    _mutations['employees'] = source?.employees != null
        ? new List<Employee>.from(source.employees
            .map((Employee entry) => new _EmployeeTemplate<Employee>(entry)))
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
// Target: abstract class Person
// **************************************************************************

/// The immutable implementation of [Person]
class PersonImm implements Person {
  @override
  final String firstName;
  @override
  final String lastName;
  PersonImm({this.firstName, this.lastName});

  factory PersonImm.fromMap(Map<String, dynamic> source) => new PersonImm(
      firstName: source['firstName'], lastName: source['lastName']);

  factory PersonImm.fromLens(void predicate(_PersonTemplate<Person> template)) {
    final _PersonTemplate<Person> template = new _PersonTemplate<Person>(null);
    predicate(template);
    return new PersonImm.fromMap(template._mutations);
  }

  PersonImm lens(void predicate(_PersonTemplate<Person> template)) {
    final _PersonTemplate<Person> template = new _PersonTemplate<Person>(this);
    predicate(template);
    return new PersonImm.fromMap(template._mutations);
  }

  Map<String, dynamic> toJson() =>
      <String, dynamic>{'firstName': this.firstName, 'lastName': this.lastName};
}

/// The mutable interface for [Person]
abstract class PersonMut extends Person {
  @override
  String get firstName;
  set firstName(String value);

  @override
  String get lastName;
  set lastName(String value);
}

/// The template implementation of [PersonMut]
class _PersonTemplate<T extends Person> implements PersonMut {
  final T source;
  final Map<String, dynamic> _mutations = <String, dynamic>{};

  @override
  String get firstName => _mutations['firstName'];
  @override
  set firstName(String value) {
    _mutations['firstName'] = value;
  }

  @override
  String get lastName => _mutations['lastName'];
  @override
  set lastName(String value) {
    _mutations['lastName'] = value;
  }

  _PersonTemplate(this.source) {
    _mutations['firstName'] = source?.firstName;
    _mutations['lastName'] = source?.lastName;
  }

  Map<String, dynamic> _mappify() => <String, dynamic>{
        'firstName': _mutations['firstName'],
        'lastName': _mutations['lastName']
      };
}

// **************************************************************************
// Generator: OpticsGenerator
// Target: abstract class PersonWithAddress
// **************************************************************************

/// The immutable implementation of [PersonWithAddress]
class PersonWithAddressImm extends PersonImm implements PersonWithAddress {
  @override
  final Address address;
  PersonWithAddressImm({this.address, String firstName, String lastName})
      : super(firstName: firstName, lastName: lastName);

  factory PersonWithAddressImm.fromMap(Map<String, dynamic> source) =>
      new PersonWithAddressImm(
          address: source['address'] != null
              ? new AddressImm.fromMap(
                  source['address'] is _AddressTemplate<Address>
                      ? source['address']._mappify()
                      : source['address'] is AddressImm
                          ? source['address'].toJson()
                          : source['address'])
              : null,
          firstName: source['firstName'],
          lastName: source['lastName']);

  factory PersonWithAddressImm.fromLens(
      void predicate(_PersonWithAddressTemplate<PersonWithAddress> template)) {
    final _PersonWithAddressTemplate<PersonWithAddress> template =
        new _PersonWithAddressTemplate<PersonWithAddress>(null);
    predicate(template);
    return new PersonWithAddressImm.fromMap(template._mutations);
  }

  @override
  PersonWithAddressImm lens(
      void predicate(_PersonWithAddressTemplate<PersonWithAddress> template)) {
    final _PersonWithAddressTemplate<PersonWithAddress> template =
        new _PersonWithAddressTemplate<PersonWithAddress>(this);
    predicate(template);
    return new PersonWithAddressImm.fromMap(template._mutations);
  }

  @override
  Map<String, dynamic> toJson() =>
      super.toJson()..addAll(<String, dynamic>{'address': this.address});
}

/// The mutable interface for [PersonWithAddress]
abstract class PersonWithAddressMut extends PersonWithAddress with PersonMut {
  @override
  AddressMut get address;
  set address(Address value);
}

/// The template implementation of [PersonWithAddressMut]
class _PersonWithAddressTemplate<T extends PersonWithAddress>
    extends _PersonTemplate<T> implements PersonWithAddressMut {
  @override
  AddressMut get address {
    if (_mutations['address'] == null)
      _mutations['address'] = new _AddressTemplate<Address>(null);
    return _mutations['address'];
  }

  @override
  set address(Address value) {
    _mutations['address'] = value;
  }

  _PersonWithAddressTemplate(T source) : super(source) {
    _mutations['address'] = source?.address != null
        ? new _AddressTemplate<Address>(source.address)
        : null;
  }

  @override
  Map<String, dynamic> _mappify() => super._mappify()
    ..addAll(<String, dynamic>{'address': _mutations['address']});
}

// **************************************************************************
// Generator: OpticsGenerator
// Target: abstract class Employee
// **************************************************************************

/// The immutable implementation of [Employee]
class EmployeeImm extends PersonWithAddressImm implements Employee {
  @override
  final int id;
  @override
  final Employee reportsTo;
  EmployeeImm(
      {this.id,
      this.reportsTo,
      Address address,
      String firstName,
      String lastName})
      : super(address: address, firstName: firstName, lastName: lastName);

  factory EmployeeImm.fromMap(Map<String, dynamic> source) => new EmployeeImm(
      id: source['id'],
      reportsTo: source['reportsTo'] != null
          ? new EmployeeImm.fromMap(
              source['reportsTo'] is _EmployeeTemplate<Employee>
                  ? source['reportsTo']._mappify()
                  : source['reportsTo'] is EmployeeImm
                      ? source['reportsTo'].toJson()
                      : source['reportsTo'])
          : null,
      address: source['address'] != null
          ? new AddressImm.fromMap(
              source['address'] is _AddressTemplate<Address>
                  ? source['address']._mappify()
                  : source['address'] is AddressImm
                      ? source['address'].toJson()
                      : source['address'])
          : null,
      firstName: source['firstName'],
      lastName: source['lastName']);

  factory EmployeeImm.fromLens(
      void predicate(_EmployeeTemplate<Employee> template)) {
    final _EmployeeTemplate<Employee> template =
        new _EmployeeTemplate<Employee>(null);
    predicate(template);
    return new EmployeeImm.fromMap(template._mutations);
  }

  @override
  EmployeeImm lens(void predicate(_EmployeeTemplate<Employee> template)) {
    final _EmployeeTemplate<Employee> template =
        new _EmployeeTemplate<Employee>(this);
    predicate(template);
    return new EmployeeImm.fromMap(template._mutations);
  }

  @override
  Map<String, dynamic> toJson() => super.toJson()
    ..addAll(<String, dynamic>{'id': this.id, 'reportsTo': this.reportsTo});
}

/// The mutable interface for [Employee]
abstract class EmployeeMut extends Employee
    with PersonWithAddressMut, PersonMut {
  @override
  int get id;
  set id(int value);

  @override
  EmployeeMut get reportsTo;
  set reportsTo(Employee value);
}

/// The template implementation of [EmployeeMut]
class _EmployeeTemplate<T extends Employee>
    extends _PersonWithAddressTemplate<T> implements EmployeeMut {
  @override
  int get id => _mutations['id'];
  @override
  set id(int value) {
    _mutations['id'] = value;
  }

  @override
  EmployeeMut get reportsTo {
    if (_mutations['reportsTo'] == null)
      _mutations['reportsTo'] = new _EmployeeTemplate<Employee>(null);
    return _mutations['reportsTo'];
  }

  @override
  set reportsTo(Employee value) {
    _mutations['reportsTo'] = value;
  }

  _EmployeeTemplate(T source) : super(source) {
    _mutations['id'] = source?.id;
    _mutations['reportsTo'] = source?.reportsTo != null
        ? new _EmployeeTemplate<Employee>(source.reportsTo)
        : null;
  }

  @override
  Map<String, dynamic> _mappify() => super._mappify()
    ..addAll(<String, dynamic>{
      'id': _mutations['id'],
      'reportsTo': _mutations['reportsTo']
    });
}

// **************************************************************************
// Generator: OpticsGenerator
// Target: abstract class Address
// **************************************************************************

/// The immutable implementation of [Address]
class AddressImm implements Address {
  @override
  final String street;
  @override
  final String number;
  @override
  final String town;
  @override
  final String country;
  AddressImm({this.country, this.number, this.street, this.town});

  factory AddressImm.fromMap(Map<String, dynamic> source) => new AddressImm(
      country: source['country'],
      number: source['number'],
      street: source['street'],
      town: source['town']);

  factory AddressImm.fromLens(
      void predicate(_AddressTemplate<Address> template)) {
    final _AddressTemplate<Address> template =
        new _AddressTemplate<Address>(null);
    predicate(template);
    return new AddressImm.fromMap(template._mutations);
  }

  AddressImm lens(void predicate(_AddressTemplate<Address> template)) {
    final _AddressTemplate<Address> template =
        new _AddressTemplate<Address>(this);
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

/// The mutable interface for [Address]
abstract class AddressMut extends Address {
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

/// The template implementation of [AddressMut]
class _AddressTemplate<T extends Address> implements AddressMut {
  final T source;
  final Map<String, dynamic> _mutations = <String, dynamic>{};

  @override
  String get street => _mutations['street'];
  @override
  set street(String value) {
    _mutations['street'] = value;
  }

  @override
  String get number => _mutations['number'];
  @override
  set number(String value) {
    _mutations['number'] = value;
  }

  @override
  String get town => _mutations['town'];
  @override
  set town(String value) {
    _mutations['town'] = value;
  }

  @override
  String get country => _mutations['country'];
  @override
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
