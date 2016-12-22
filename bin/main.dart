import 'dart:convert';

import '../test/domain/company.g.dart';
import '../test/domain/address.g.dart';
import '../test/domain/employee.g.dart';

void main() {
  CompanyImmutable company = new CompanyImmutable.fromMap({
    'name': 'ACME corp',
    'founded': new DateTime(2016, 12 ,1)
  });

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
        template.employees.add(new EmployeeImmutable(
          address: new AddressImmutable(
            country: 'United',
            number: '17',
            street: 'Mount Ephraim Road',
            town: 'Rockport'
          ),
          firstName: 'John',
          id: 123,
          lastName: 'Doe'
        ));

        /// ...and mutate him right away
        EmployeeMutable employee = template.employees.first;

        employee.address.country += ' Kingdom';
      });

  print(new JsonEncoder.withIndent('    ', (data) {
    if (data is DateTime) return data.millisecondsSinceEpoch;

    return data.toJson();
  }).convert(company));
}