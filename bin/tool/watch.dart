import 'package:build_runner/build_runner.dart';

import 'phases.dart';

void main() {
  watch(phases, deleteFilesByDefault: true);
}