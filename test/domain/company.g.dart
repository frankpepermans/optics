// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// Generator: OpticsGenerator
// Target: abstract class Company
// **************************************************************************

import 'dart:collection';

import 'package:optics/optics.dart';

import 'company.dart';
import 'address.g.dart';
import 'employee.g.dart';

export 'company.dart';

/// All public properties for [Company]
abstract class CompanyProps {
  static const String name = 'name';

  static const String founded = 'founded';

  static const String address = 'address';

  static const String employees = 'employees';
}

/// The immutable implementation of [Company]
class CompanyImmutable implements Company, Comparable {
  @override
  final String name;
  @override
  final DateTime founded;
  @override
  final Address address;
  @override
  final Iterable<Employee> employees;
  const CompanyImmutable(
      {this.address, this.employees, this.founded, this.name});

  factory CompanyImmutable.fromMap(Map<String, dynamic> source) {
    final Address address = source['address'];
    final Iterable<Employee> employees = source['employees'];
    final DateTime founded = source['founded'];
    final String name = source['name'];
    return new CompanyImmutable(
        address: address != null
            ? new AddressImmutable.fromMap(address is AddressTemplate<Address>
                ? address.toJson()
                : address is AddressImmutable ? address.toJson() : const {})
            : null,
        employees: employees != null
            ? new UnmodifiableListView<Employee>(employees.map(
                (Employee entry) => entry is EmployeeTemplate<Employee>
                    ? new EmployeeImmutable.fromMap(entry.mutations)
                    : entry))
            : null,
        founded: founded,
        name: name);
  }

  factory CompanyImmutable.fromLens(
      void predicate(CompanyTemplate<Company> template)) {
    final CompanyTemplate<Company> template =
        new CompanyTemplate<Company>(null);
    predicate(template);
    return new CompanyImmutable.fromMap(template.mutations);
  }

  CompanyImmutable lens(void predicate(CompanyTemplate<Company> template)) {
    final CompanyTemplate<Company> template =
        new CompanyTemplate<Company>(this);
    predicate(template);
    return new CompanyImmutable.fromMap(template.mutations);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'address': this.address,
        'employees': this.employees,
        'founded': this.founded,
        'name': this.name
      };
  @override
  int compareTo(dynamic other) {
    if (other is Company) {
      return (compareObjects(address, other?.address) == 0 &&
              compareIterables(employees, other?.employees) == 0 &&
              compareObjects(founded, other?.founded) == 0 &&
              compareObjects(name, other?.name) == 0)
          ? 0
          : 1;
    }
    return -1;
  }
}

/// The mutable interface for [Company]
abstract class CompanyMutable extends Company with Comparable {
  @override
  String get name;
  set name(String value);

  @override
  DateTime get founded;
  set founded(DateTime value);

  @override
  AddressMutable get address;
  set address(Address value);

  @override
  List<Employee> get employees;
  set employees(Iterable<Employee> value);
}

/// The template implementation of [CompanyMutable]
class CompanyTemplate<T extends Company> implements CompanyMutable, Comparable {
  final T source;
  final Map<String, dynamic> mutations = <String, dynamic>{};

  @override
  String get name => mutations['name'];
  @override
  set name(String value) {
    mutations['name'] = value;
  }

  @override
  DateTime get founded => mutations['founded'];
  @override
  set founded(DateTime value) {
    mutations['founded'] = value;
  }

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

  @override
  List<Employee> get employees {
    if (mutations['employees'] == null) mutations['employees'] = <Employee>[];
    if (mutations['employees'].firstWhere(
            (Employee entry) => entry is! EmployeeTemplate<Employee>,
            orElse: () => null) !=
        null)
      mutations['employees'] = mutations['employees']
          .map((Employee entry) => entry is EmployeeTemplate<Employee>
              ? entry
              : new EmployeeTemplate<Employee>(entry))
          .toList();
    return mutations['employees'];
  }

  @override
  set employees(Iterable<Employee> value) {
    mutations['employees'] = value;
  }

  CompanyTemplate(this.source) {
    mutations['address'] = source?.address != null
        ? new AddressTemplate<Address>(source.address)
        : null;
    mutations['employees'] = source?.employees != null
        ? new List<Employee>.from(source.employees
            .map((Employee entry) => new EmployeeTemplate<Employee>(entry)))
        : null;
    mutations['founded'] = source?.founded;
    mutations['name'] = source?.name;
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'address': mutations['address'],
        'employees': mutations['employees'],
        'founded': mutations['founded'],
        'name': mutations['name']
      };
  @override
  int compareTo(dynamic other) => -1;
}
