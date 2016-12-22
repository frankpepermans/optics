library benchmark;

import 'dart:convert';

import 'package:benchmark_harness/benchmark_harness.dart';

import 'domain/test_entity.g.dart';

void main() => TemplateBenchmark.main();

List<String> jsonRaw = <String>[];

class TemplateBenchmark extends BenchmarkBase {

  const TemplateBenchmark() : super("Template");

  static void main() => new TemplateBenchmark().report();

  void run() {
    for (int i=0, len=jsonRaw.length; i<len; i++) new TestEntityImmutable.fromMap(JSON.decode(jsonRaw[i]));
  }

  void setup() {
    final int loopCount = 10000;
    int i = loopCount;

    while (i > 0) jsonRaw.add('{"id":${--i},"name":"Speed test","type":"type_${i}"}');
  }
}