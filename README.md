[![Build Status](https://travis-ci.org/frankpepermans/optics.svg)](https://travis-ci.org/frankpepermans/optics)
[![Coverage Status](https://coveralls.io/repos/github/frankpepermans/optics/badge.svg?branch=master)](https://coveralls.io/github/frankpepermans/optics?branch=master)

# optics
Is a POC/playground library to facilitate working with immutable data in Dart.

It relies very heavily on [source_gen](https://pub.dartlang.org/packages/source_gen), the idea is to
generate both immutable and mutable implementations of abstract classes.

The immutable implementation is what you see, the mutable implementation only
exists within the mutation phase (or lens phase).

Assume we build the following domain.dart file with 3 entities:

```dart
/// handwritten .dart file which describes the entity
 
@optics
abstract class Company {
 
  String get name;
 
  DateTime get founded;
 
  Address get address;
 
  Iterable<Employee> get employees;
}
 
@optics
abstract class Employee {
 
  int get id;
 
  String get firstName;
 
  String get lastName;
 
  Address get address;
 
  Employee get reportsTo;
}
 
@optics
abstract class Address {
 
  String get street;
 
  String get number;
 
  String get town;
 
  String get country;
}
```

The <code>@optics</code> annotation marks the class for source_gen. (note that only abstract classes with getters are supported)

source_gen will provide us with public immutable classes, such as:

```dart
/// Generated immutable file
 
class CompanyImm implements Company {
  
  final String name;
   
  final DateTime founded;
   
  final Address address;
   
  final Iterable<Employee> employees;
   
  CompanyImm(this.address, this.employees, this.founded, this.name);
  
  ...
}
```

The interesting part is mutating the immutable instances out of the box:

```dart
void main() {
  /// Let's use the fromMap constructor, assuming we received JSON data
  /// Note that I'm not bothering with providing the company address
   
  CompanyImm company = new CompanyImm.fromMap({
    'name': 'ACME corp',
    'founded': new DateTime(2016, 12 ,1)
  });
  
  /// now let's mutate it
  company = company
        .lens((template) {
          ///
          /// template is typed and implements [CompanyMut], which is a generated getter/setter company interface
          /// we cannot create a new Company template ourselves, it only exists within the lens function
          ///
          /// template.address is null in the immutable
          /// but for convenience, the template auto-creates an address template when accessing the address getter
          ///
          template.address.street = 'Main Street';
          template.address.town = 'Looney Tunes Town';
      
          /// We can also add an employee
          template.employees.add(new EmployeeImm(
            new AddressImm(
              'United',
              '17',
              'Mount Ephraim Road',
              'Rockport'
            ),
            'John',
            123,
            'Doe',
            null
          ));
      
          /// ...and mutate him right away
          /// note: even though an EmployeeImm was used to add this employee,
          /// because we run in template mode, we always get a mutable Employee object instead
          EmployeeMut employee = template.employees.first;
      
          employee.address.country += ' Kingdom';
        });
  
  /// company is now a mutated Company immutable, let's print it out:
  print(new JsonEncoder.withIndent('    ', (data) {
      if (data is DateTime) return data.millisecondsSinceEpoch;
  
      return data.toJson();
    }).convert(company));
  
  /// prints:
  /// --------------------------------------
  /** {
          "address": {
              "country": null,
              "number": null,
              "street": "Main Street",
              "town": "Looney Tunes Town"
          },
          "employees": [
              {
                  "address": {
                      "country": "United Kingdom",
                      "number": "17",
                      "street": "Mount Ephraim Road",
                      "town": "Rockport"
                  },
                  "firstName": "John",
                  "id": 123,
                  "lastName": "Doe",
                  "reportsTo": null
              }
          ],
          "founded": 1480546800000,
          "name": "ACME corp"
      }
  */
  /// --------------------------------------
  
  /// Let's just check the type after the lens operation:
  print(company.employees.first.runtimeType); /// => EmployeeImm
  
  /// Looking good! An immutable class where all properties are final!
  /// See the class below
}
```

```dart
class EmployeeImm implements Employee {
   
  final int id;
   
  final String firstName;
   
  final String lastName;
   
  final Address address;
   
  final Employee reportsTo;
   
  EmployeeImm(
      this.address, this.firstName, this.id, this.lastName, this.reportsTo);

  ...
}
```

Please see the [test sources](https://github.com/frankpepermans/optics/tree/master/test) for more examples!
