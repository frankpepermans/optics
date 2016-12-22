import '../test/domain/company.g.dart';
import '../test/domain/address.g.dart';
import '../test/domain/employee.g.dart';

final CompanyImmutable company_A = new CompanyImmutable.fromMap(<String, dynamic>{
  'name': 'Springfield nuclear power plant',
  'founded': new DateTime(1950, 4, 1),
  'employees': <Employee>[employee_A, employee_B, employee_C]
});

final EmployeeImmutable employee_A = new EmployeeImmutable.fromMap(<String, dynamic>{
  'id': 999,
  'firstName': 'Homer',
  'lastName': 'Simpson',
  'address': address_A,
  'reportsTo': employee_B
});

final EmployeeImmutable employee_B = new EmployeeImmutable.fromMap(<String, dynamic>{
  'id': 2,
  'firstName': 'Waylon',
  'lastName': 'Smithers',
  'reportsTo': employee_C
});

final EmployeeImmutable employee_C = new EmployeeImmutable.fromMap(<String, dynamic>{
  'id': 1,
  'firstName': 'Montgomery',
  'lastName': 'Burns'
});

final AddressImmutable address_A = new AddressImmutable.fromMap(<String, dynamic>{
  'street': 'Evergreen Terrace',
  'number': '742',
  'town': 'Springfield',
  'country': 'USA'
});