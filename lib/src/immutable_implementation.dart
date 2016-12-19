import 'package:analyzer/dart/element/element.dart';

import 'package:optics/src/class_builder.dart';

import 'package:optics/src/element_utils.dart' as utils;

class ImmutableImplementation extends ClassBuilder {

  ImmutableImplementation(ClassElement element) :
    super(element, suffix: 'Imm', isAbstract: false, isPrivate: false, implementsList: <String>[element.displayName], comment: 'The immutable implementation of [${element.displayName}]');

  @override
  String writeConstructor() {
    final StringBuffer buffer = new StringBuffer();

    buffer.writeln(super.writeConstructor());

    buffer.writeln();

    buffer.writeln(writeFromMapFactoryConstructor());
    buffer.writeln(writeFromLensFactoryConstructor());

    buffer.writeln();

    buffer.writeln();

    return buffer.toString();
  }

  @override
  String writeBody() {
    final StringBuffer buffer = new StringBuffer();
    final String properties = utils.getAlphabetizedProperties(element)
      .map((PropertyAccessorElement property) => property.displayName)
      .map((String propertyName) => ''' '$propertyName':this.$propertyName ''')
      .join(', ');

    buffer.writeln('$className lens(void predicate(_${element.displayName}Template template)) {');
    buffer.writeln('final _${element.displayName}Template template = new _${element.displayName}Template(this);');
    buffer.writeln('predicate(template);');
    buffer.writeln('return new $className.fromMap(template._mutations);');
    buffer.writeln('}');

    buffer.writeln('Map<String, dynamic> toJson() => <String, dynamic>{$properties};');

    return buffer.toString();
  }

  String writeFromMapFactoryConstructor() {
    final StringBuffer buffer = new StringBuffer();
    final List<PropertyAccessorElement> properties = utils.getAlphabetizedProperties(element);
    final String args = properties
        .map(utils.getPropertyData)
        .map((utils.PropertyData propertyData) {
          if (propertyData is utils.CustomObjectData) return '''source['${propertyData.property.displayName}'] != null ? new ${propertyData.asImmutableDisplayName}.fromMap(source['${propertyData.property.displayName}'] is _${propertyData.asInterfaceDisplayName}Template ? source['${propertyData.property.displayName}']._mappify() : source['${propertyData.property.displayName}'] is ${propertyData.asInterfaceDisplayName}Imm ? source['${propertyData.property.displayName}'].toJson() : source['${propertyData.property.displayName}']) : null''';
          else if (propertyData is utils.ListData) return '''source['${propertyData.property.displayName}'] != null ? new ${propertyData.asImmutableDisplayName}(source['${propertyData.property.displayName}'].toList(growable: false)) : null''';
          return '''source['${propertyData.property.displayName}']''';
        })
        .join(', ');

    buffer.writeln('factory $className.fromMap(Map<String, dynamic> source) => new $className($args);');

    return buffer.toString();
  }

  String writeFromLensFactoryConstructor() {
    final StringBuffer buffer = new StringBuffer();

    buffer.writeln('factory $className.fromLens(void predicate(_${element.displayName}Template template)) {');
    buffer.writeln('final _${element.displayName}Template template = new _${element.displayName}Template(null);');
    buffer.writeln('predicate(template);');
    buffer.writeln('return new $className.fromMap(template._mutations);');
    buffer.writeln('}');

    return buffer.toString();
  }
}