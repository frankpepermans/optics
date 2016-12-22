import 'package:test/test.dart';

import 'mock/mock_data.dart' as data;

import 'domain/employee.g.dart';
import 'domain/company.g.dart';

void main() {

  String stringifyEmployee(Employee employee) => '${employee.firstName} ${employee.lastName}';

  test('Simple change', () {
    CompanyImmutable company = data.company_A.lens((template) {
      template.name = 'Shelbyville nuclear power plant';
    });

    expect(company.name, 'Shelbyville nuclear power plant');
    expect(company, isNot(data.company_A));
  });

  test('Reference change', () {
    EmployeeImmutable employee = data.employee_C.lens((template) {
      template.reportsTo = data.employee_A;
    });

    expect('${stringifyEmployee(employee)} reports to ${stringifyEmployee(data.employee_A)}', 'Montgomery Burns reports to Homer Simpson');
  });

  test('New instance', () {
    CompanyImmutable company = data.company_A.lens((template) {
      template.employees.add(new EmployeeImmutable.fromMap(<String, dynamic>{
        'firstName': 'Carl'
      }));

      (template.employees.last as EmployeeMutable).reportsTo.firstName = 'Lenny';
    });

    expect(company.employees.last.reportsTo.firstName, 'Lenny');
  });
}