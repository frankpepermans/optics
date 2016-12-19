import 'package:build_runner/build_runner.dart';

import 'phases.dart';

bool test = true;

main() async {
  await build(phases, deleteFilesByDefault: true);
}