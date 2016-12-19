import 'dart:convert';

import 'package:test/test.dart';

import 'mock_data.dart' as data;

void main() {

  test('...json encode', () {
    expect(JSON.encode(data.company_A, toEncodable:(data) {
      if (data is DateTime) return data.millisecondsSinceEpoch;

      return data.toJson();
    }), '{"address":null,"employees":[{"address":{"country":"USA","number":"742","street":"Evergreen Terrace","town":"Springfield"},"firstName":"Homer","id":999,"lastName":"Simpson","reportsTo":{"address":null,"firstName":"Waylon","id":2,"lastName":"Smithers","reportsTo":{"address":null,"firstName":"Montgomery","id":1,"lastName":"Burns","reportsTo":null}}},{"address":null,"firstName":"Waylon","id":2,"lastName":"Smithers","reportsTo":{"address":null,"firstName":"Montgomery","id":1,"lastName":"Burns","reportsTo":null}},{"address":null,"firstName":"Montgomery","id":1,"lastName":"Burns","reportsTo":null}],"founded":-623376000000,"name":"Springfield nuclear power plant"}');
  });
}