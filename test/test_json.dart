import 'dart:convert';

import 'package:test/test.dart';

import 'mock/mock_data.dart' as data;

void main() {

  test('...json encode', () {
    expect(JSON.encode(data.company_A, toEncodable:(data) {
      if (data is DateTime) return data.millisecondsSinceEpoch;

      return data.toJson();
    }), '{"address":null,"employees":[{"firstName":"Homer","lastName":"Simpson","address":{"country":"USA","number":"742","street":"Evergreen Terrace","town":"Springfield"},"id":999,"reportsTo":{"firstName":"Waylon","lastName":"Smithers","address":null,"id":2,"reportsTo":{"firstName":"Montgomery","lastName":"Burns","address":null,"id":1,"reportsTo":null}}},{"firstName":"Waylon","lastName":"Smithers","address":null,"id":2,"reportsTo":{"firstName":"Montgomery","lastName":"Burns","address":null,"id":1,"reportsTo":null}},{"firstName":"Montgomery","lastName":"Burns","address":null,"id":1,"reportsTo":null}],"founded":-623376000000,"name":"Springfield nuclear power plant"}');
  });
}