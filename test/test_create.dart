import 'package:test/test.dart';

import 'mock_data.dart' as data;

import 'domain.dart';

void main() {

  String stringifyEmployee(Employee employee) => '${employee.firstName} ${employee.lastName}';

  test('Immutable Object creation from Map', () {
    expect(data.company_A.name, 'Springfield nuclear power plant');
    expect(data.company_A.founded.millisecondsSinceEpoch, new DateTime(1950, 4, 1).millisecondsSinceEpoch);
    expect(data.company_A.employees, isNotNull);
  });

  test('...to create recursively', () {
    expect(data.company_A.employees
        .map(stringifyEmployee), contains(stringifyEmployee(data.employee_B)));
    expect(stringifyEmployee(data.company_A.employees.first.reportsTo.reportsTo), stringifyEmployee(data.employee_C));
  });
}