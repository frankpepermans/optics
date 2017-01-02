import 'dart:async';

import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:source_gen/source_gen.dart';

import 'package:optics/src/properties_implementation.dart';
import 'package:optics/src/immutable_implementation.dart';
import 'package:optics/src/abstract_mutable_implementation.dart';
import 'package:optics/src/template_implementation.dart';
import 'package:optics/src/element_utils.dart' as utils;

class OpticsGenerator extends Generator {

  @override
  Future<String> generate(Element element, _) async {
    if (element is ClassElement) {
      final ElementAnnotation opticsAnnotation = element.metadata
          .firstWhere((ElementAnnotation annotation) => annotation.element.name.compareTo('optics') == 0, orElse: () => null);

      if (opticsAnnotation != null) {
        if (!element.isAbstract) throw new ArgumentError('The optics annotation can only be used on abstract classes');

        final StringBuffer buffer = new StringBuffer();

        buffer.writeln('''import 'dart:collection';''');
        buffer.writeln();

        final List<Set<String>> imports = utils.getImports(element);

        buffer.writeln();

        final List<String> packagesAsList = imports.last.toList(growable: false)..sort();

        buffer.writeln(packagesAsList.join(''));
        buffer.writeln();
        buffer.writeln('''import '${element.enclosingElement.displayName}';''');

        final List<String> hierarchyAsList = imports.first.toList(growable: false)..sort();

        buffer.writeln(hierarchyAsList.join(''));

        buffer.writeln();

        buffer.writeln('''export '${element.enclosingElement.displayName}';''');

        buffer.writeln(new PropertiesImplementation(element).write());
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