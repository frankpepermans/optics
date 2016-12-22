import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';

import 'package:optics/src/class_builder.dart';

import 'package:optics/src/element_utils.dart' as utils;

class ImmutableImplementation extends ClassBuilder {

  ImmutableImplementation(ClassElement element) :
    super(element, suffix: ClassBuilder.immutable_suffix, isAbstract: false, isPrivate: false, implementsList: <String>[element.displayName], comment: 'The immutable implementation of [${element.displayName}]');

  @override
  String writeDeclaration({List<String> genericTypes: const [], Iterable<String> customExtendsList: const [], Iterable<String> customImplementsList: const [], Iterable<String> customMixinsList: const []}) {
    return super.writeDeclaration(customExtendsList: element.allSupertypes
      .map((InterfaceType type) => type.displayName)
      .where((String type) => type.compareTo('Object') != 0)
      .map((String type) => '${type}${ClassBuilder.immutable_suffix}'));
  }

  @override
  String writeConstructor() {
    final StringBuffer buffer = new StringBuffer();
    final List<String> superProperties = <String>[];
    final List<String> allProperties = <String>[];

    if (isSubClass) {
      element.allSupertypes
          .where((InterfaceType type) => type.displayName.compareTo('Object') != 0)
          .forEach((InterfaceType type) => superProperties.addAll(utils.getAlphabetizedProperties(type.element)
            .map((PropertyAccessorElement property) => '${property.returnType.displayName} ${property.displayName}')));
    }

    allProperties.addAll(utils.getAlphabetizedProperties(element)
        .map((PropertyAccessorElement property) => property.displayName)
        .map((String propertyName) => 'this.$propertyName'));

    allProperties.addAll(superProperties);

    if (isSubClass) {
      final String superArgs = superProperties
        .map((String value) => value.split(' ').last)
        .map((String value) => '$value:$value')
        .join(', ');

      buffer.writeln('$className({${allProperties.join(', ')}}) : super($superArgs);');
    } else buffer.writeln('$className({${allProperties.join(', ')}});');

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

    if (isSubClass) buffer.writeln('@override $className lens(void predicate(${element.displayName}Template<${element.displayName}> template)) {');
    else buffer.writeln('$className lens(void predicate(${element.displayName}Template<${element.displayName}> template)) {');

    buffer.writeln('final ${element.displayName}Template<${element.displayName}> template = new ${element.displayName}Template<${element.displayName}>(this);');
    buffer.writeln('predicate(template);');
    buffer.writeln('return new $className.fromMap(template.mutations);');
    buffer.writeln('}');

    if (isSubClass) buffer.writeln('@override Map<String, dynamic> toJson() => super.toJson()..addAll(<String, dynamic>{$properties});');
    else buffer.writeln('Map<String, dynamic> toJson() => <String, dynamic>{$properties};');

    return buffer.toString();
  }

  String writeFromMapFactoryConstructor() {
    final StringBuffer buffer = new StringBuffer();
    final List<PropertyAccessorElement> properties = utils.getRecursiveAlphabetizedProperties(element);

    final String values = properties
        .map(utils.getPropertyData)
        .map((utils.PropertyData propertyData) => '''final ${propertyData.property.returnType.displayName} ${propertyData.property.displayName} = source['${propertyData.property.displayName}']''')
        .join(';');

    final String args = properties
        .map(utils.getPropertyData)
        .map((utils.PropertyData propertyData) {
          if (propertyData is utils.CustomObjectData) return '''${propertyData.property.displayName}:${propertyData.property.displayName} != null ? new ${propertyData.asImmutableDisplayName}.fromMap(${propertyData.property.displayName} is ${propertyData.asInterfaceDisplayName}Template<${propertyData.asInterfaceDisplayName}> ? ${propertyData.property.displayName}.mappify() : ${propertyData.property.displayName} is ${propertyData.asInterfaceDisplayName}${ClassBuilder.immutable_suffix} ? ${propertyData.property.displayName}.toJson() : const {}) : null''';
          else if (propertyData is utils.ListData) return '''${propertyData.property.displayName}:${propertyData.property.displayName} != null ? new ${propertyData.asImmutableDisplayName}(${propertyData.property.displayName}.map((${propertyData.genericType} entry) => entry is ${propertyData.genericType}Template<${propertyData.genericType}> ? new ${propertyData.genericType}${ClassBuilder.immutable_suffix}.fromMap(entry.mutations) : entry)) : null''';
          return '''${propertyData.property.displayName}:${propertyData.property.displayName}''';
        })
        .join(', ');

    buffer.writeln('factory $className.fromMap(Map<String, dynamic> source) {$values;return new $className($args);}');

    return buffer.toString();
  }

  String writeFromLensFactoryConstructor() {
    final StringBuffer buffer = new StringBuffer();

    buffer.writeln('factory $className.fromLens(void predicate(${element.displayName}Template<${element.displayName}> template)) {');
    buffer.writeln('final ${element.displayName}Template<${element.displayName}> template = new ${element.displayName}Template<${element.displayName}>(null);');
    buffer.writeln('predicate(template);');
    buffer.writeln('return new $className.fromMap(template.mutations);');
    buffer.writeln('}');

    return buffer.toString();
  }
}