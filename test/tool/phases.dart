import 'package:build_runner/build_runner.dart';

import 'package:optics/src/optics_generator.dart';
import 'package:source_gen/source_gen.dart';

final PhaseGroup phases = new PhaseGroup.singleAction(
    new GeneratorBuilder(const <Generator>[
      const OpticsGenerator()
    ]),
    new InputSet('optics',
        const <String>['test/domain.dart']));