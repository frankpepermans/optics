import 'dart:async';

import 'package:build_runner/build_runner.dart';

import 'phases.dart';

bool test = true;

Future<dynamic> main() async {
  await build(phases, deleteFilesByDefault: true);
}