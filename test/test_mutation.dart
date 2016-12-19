import 'package:test/test.dart';

import 'mock_data.dart' as data;

import 'domain.dart';

void main() {

  String stringifyEmployee(Employee employee) => '${employee.firstName} ${employee.lastName}';

  test('Simple change', () {
    CompanyImm company = data.company_A.lens((template) {
      template.name = 'Shelbyville nuclear power plant';
    });

    expect(company.name, 'Shelbyville nuclear power plant');
    expect(company, isNot(data.company_A));
  });

  test('Reference change', () {
    EmployeeImm employee = data.employee_C.lens((template) {
      template.reportsTo = data.employee_A;
    });

    expect('${stringifyEmployee(employee)} reports to ${stringifyEmployee(data.employee_A)}', 'Montgomery Burns reports to Homer Simpson');
  });

  test('New instance', () {
    CompanyImm company = data.company_A.lens((template) {
      template.employees.add(new EmployeeImm.fromMap(<String, dynamic>{
        'firstName': 'Carl'
      }));

      (template.employees.last as EmployeeMut).reportsTo.firstName = 'Lenny';
    });

    expect(company.employees.last.reportsTo.firstName, 'Lenny');
  });
}