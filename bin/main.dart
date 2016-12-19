import 'dart:convert';

import 'package:optics/optics.dart';

import '../test/mock_data.dart' as data;

void main() {
  print(JSON.encode(data.company_A, toEncodable:(data) {
    if (data is DateTime) return data.millisecondsSinceEpoch;

    return data.toJson();
  }));
}