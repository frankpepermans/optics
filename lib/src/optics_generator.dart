import 'dart:async';

import 'package:analyzer/dart/element/element.dart';
import 'package:source_gen/source_gen.dart';

import 'package:optics/src/immutable_implementation.dart';
import 'package:optics/src/abstract_mutable_implementation.dart';
import 'package:optics/src/template_implementation.dart';

class OpticsGenerator extends Generator {

  @override
  Future<String> generate(Element element, _) async {
    if (element is ClassElement) {
      final ElementAnnotation opticsAnnotation = element.metadata
          .firstWhere((ElementAnnotation annotation) => annotation.element.name.compareTo('optics') == 0, orElse: () => null);

      if (opticsAnnotation != null) {
        if (!element.isAbstract) throw new ArgumentError('The optics annotation can only be used on abstract classes');

        final StringBuffer buffer = new StringBuffer();

        buffer.writeln(new ImmutableImplementation(element).write());
        buffer.writeln(new AbstractMutableImplementation(element).write());
        buffer.writeln(new TemplateImplementation(element).write());

        return buffer.toString();
      }
    }

    return null;
  }

  const OpticsGenerator();

}