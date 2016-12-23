// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// Generator: OpticsGenerator
// Target: abstract class Employee
// **************************************************************************

import 'dart:collection';

import 'package:optics/optics.dart';

import 'employee.dart';
import 'address.g.dart';
import 'person.g.dart';
import 'person_with_address.g.dart';

export 'employee.dart';

/// All public properties for [Employee]
abstract class EmployeeProps {
  static const String id = 'id';

  static const String reportsTo = 'reportsTo';
}

/// The immutable implementation of [Employee]
class EmployeeImmutable extends PersonWithAddressImmutable implements Employee {
  @override
  final int id;
  @override
  final Employee reportsTo;
  EmployeeImmutable(
      {this.id,
      this.reportsTo,
      Address address,
      String firstName,
      String lastName})
      : super(address: address, firstName: firstName, lastName: lastName);

  factory EmployeeImmutable.fromMap(Map<String, dynamic> source) {
    final int id = source['id'];
    final Employee reportsTo = source['reportsTo'];
    final Address address = source['address'];
    final String firstName = source['firstName'];
    final String lastName = source['lastName'];
    return new EmployeeImmutable(
        id: id,
        reportsTo: reportsTo != null
            ? new EmployeeImmutable.fromMap(
                reportsTo is EmployeeTemplate<Employee>
                    ? reportsTo.toJson()
                    : reportsTo is EmployeeImmutable
                        ? reportsTo.toJson()
                        : const {})
            : null,
        address: address != null
            ? new AddressImmutable.fromMap(address is AddressTemplate<Address>
                ? address.toJson()
                : address is AddressImmutable ? address.toJson() : const {})
            : null,
        firstName: firstName,
        lastName: lastName);
  }

  factory EmployeeImmutable.fromLens(
      void predicate(EmployeeTemplate<Employee> template)) {
    final EmployeeTemplate<Employee> template =
        new EmployeeTemplate<Employee>(null);
    predicate(template);
    return new EmployeeImmutable.fromMap(template.mutations);
  }

  @override
  EmployeeImmutable lens(void predicate(EmployeeTemplate<Employee> template)) {
    final EmployeeTemplate<Employee> template =
        new EmployeeTemplate<Employee>(this);
    predicate(template);
    return new EmployeeImmutable.fromMap(template.mutations);
  }

  @override
  Map<String, dynamic> toJson() => super.toJson()
    ..addAll(<String, dynamic>{'id': this.id, 'reportsTo': this.reportsTo});
}

/// The mutable interface for [Employee]
abstract class EmployeeMutable extends Employee
    with PersonWithAddressMutable, PersonMutable {
  @override
  int get id;
  set id(int value);

  @override
  EmployeeMutable get reportsTo;
  set reportsTo(Employee value);
}

/// The template implementation of [EmployeeMutable]
class EmployeeTemplate<T extends Employee> extends PersonWithAddressTemplate<T>
    implements EmployeeMutable {
  @override
  int get id => mutations['id'];
  @override
  set id(int value) {
    mutations['id'] = value;
  }

  @override
  EmployeeMutable get reportsTo {
    if (mutations['reportsTo'] == null)
      mutations['reportsTo'] = new EmployeeTemplate<Employee>(null);
    return mutations['reportsTo'];
  }

  @override
  set reportsTo(Employee value) {
    mutations['reportsTo'] = value;
  }

  EmployeeTemplate(T source) : super(source) {
    mutations['id'] = source?.id;
    mutations['reportsTo'] = source?.reportsTo != null
        ? new EmployeeTemplate<Employee>(source.reportsTo)
        : null;
  }

  @override
  Map<String, dynamic> toJson() => super.toJson()
    ..addAll(<String, dynamic>{
      'id': mutations['id'],
      'reportsTo': mutations['reportsTo']
    });
}
