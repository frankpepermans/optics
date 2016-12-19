import 'domain.dart';

final CompanyImm company_A = new CompanyImm.fromMap(<String, dynamic>{
  'name': 'Springfield nuclear power plant',
  'founded': new DateTime(1950, 4, 1),
  'employees': <Employee>[employee_A, employee_B, employee_C]
});

final EmployeeImm employee_A = new EmployeeImm.fromMap(<String, dynamic>{
  'id': 999,
  'firstName': 'Homer',
  'lastName': 'Simpson',
  'address': address_A,
  'reportsTo': employee_B
});

final EmployeeImm employee_B = new EmployeeImm.fromMap(<String, dynamic>{
  'id': 2,
  'firstName': 'Waylon',
  'lastName': 'Smithers',
  'reportsTo': employee_C
});

final EmployeeImm employee_C = new EmployeeImm.fromMap(<String, dynamic>{
  'id': 1,
  'firstName': 'Montgomery',
  'lastName': 'Burns'
});

final AddressImm address_A = new AddressImm.fromMap(<String, dynamic>{
  'street': 'Evergreen Terrace',
  'number': '742',
  'town': 'Springfield',
  'country': 'USA'
});