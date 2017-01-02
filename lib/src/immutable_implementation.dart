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
      .where((InterfaceType type) => type.displayName.compareTo('Object') != 0)
      .map((InterfaceType type) {
        if (type.element.library.isDartCore) return type.displayName;

        return '${type.displayName}${ClassBuilder.immutable_suffix}';
      }));
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

    final String allPropertiesList = allProperties.isNotEmpty ? '''{${allProperties.join(', ')}}''' : '';

    if (isSubClass) {
      final String superArgs = superProperties
        .map((String value) => value.split(' ').last)
        .map((String value) => '$value:$value')
        .join(', ');

      buffer.writeln('const $className($allPropertiesList) : super($superArgs);');
    } else buffer.writeln('const $className($allPropertiesList);');

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
    final String comparisons = utils.getAlphabetizedProperties(element)
      .map((PropertyAccessorElement property) {
        if (utils.getPropertyData(property) is utils.ListData) return 'compareIterables(${property.displayName}, other?.${property.displayName}) == 0';

        return 'compareObjects(${property.displayName}, other?.${property.displayName}) == 0';
      })
      .join(' && ');
    final Iterable<String> genericClassTypes = utils.getRecursiveAlphabetizedProperties(element)
        .map(utils.getPropertyData)
        .where((utils.PropertyData propertyData) => propertyData.isGenericClassType)
        .map((utils.PropertyData propertyData) => propertyData.asInterfaceDisplayName);

    if (genericClassTypes.isNotEmpty) {
      if (isSubClass) buffer.writeln('@override $className lens(void predicate(${element.displayName}Template<${element.displayName}<${genericClassTypes.join(', ')}>, ${genericClassTypes.join(', ')}> template)) {');
      else buffer.writeln('$className lens(void predicate(${element.displayName}Template<${element.displayName}<${genericClassTypes.join(', ')}>, ${genericClassTypes.join(', ')}> template)) {');

      buffer.writeln('final ${element.displayName}Template<${element.displayName}<${genericClassTypes.join(', ')}>, ${genericClassTypes.join(', ')}> template = new ${element.displayName}Template<${element.displayName}<${genericClassTypes.join(', ')}>, ${genericClassTypes.join(', ')}>(this);');
    } else {
      if (isSubClass) buffer.writeln('@override $className lens(void predicate(${element.displayName}Template<${element.displayName}> template)) {');
      else buffer.writeln('$className lens(void predicate(${element.displayName}Template<${element.displayName}> template)) {');

      buffer.writeln('final ${element.displayName}Template<${element.displayName}> template = new ${element.displayName}Template<${element.displayName}>(this);');
    }

    buffer.writeln('predicate(template);');
    buffer.writeln('return new $className.fromMap(template.mutations);');
    buffer.writeln('}');

    if (isSubClass) buffer.writeln('@override Map<String, dynamic> toJson() => super.toJson()..addAll(<String, dynamic>{$properties});');
    else buffer.writeln('Map<String, dynamic> toJson() => <String, dynamic>{$properties};');

    if (comparisons.isNotEmpty) {
      buffer.writeln('@override int compareTo(dynamic other) {');

      if (isSubClass) buffer.writeln('if (other is ${element.displayName} && super.compareTo(other) == 0) {return ($comparisons) ? 0 : 1;}');
      else buffer.writeln('if (other is ${element.displayName}) {return ($comparisons) ? 0 : 1;}');

      buffer.writeln('return -1;}');
    } else {
      if (!isSubClass) buffer.writeln('@override int compareTo(dynamic other) => 0;');
    }

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
          if (propertyData is utils.CustomObjectData) {
            return '''${propertyData.property.displayName}:${propertyData.property.displayName} != null ? new ${propertyData.asImmutableDisplayName}.fromMap(${propertyData.property.displayName} is ${propertyData.asInterfaceDisplayName}Template<${propertyData.asInterfaceDisplayName}> ? ${propertyData.property.displayName}.toJson() : ${propertyData.property.displayName} is ${propertyData.asInterfaceDisplayName}${ClassBuilder.immutable_suffix} ? ${propertyData.property.displayName}.toJson() : const {}) : null''';
          } else if (propertyData is utils.ListData) {
            if (utils.isCustomObject(element, propertyData.genericType)) {
              return '''${propertyData.property.displayName}:${propertyData.property.displayName} != null ? new ${propertyData.asImmutableDisplayName}(${propertyData.property.displayName}.map((${propertyData.genericType} entry) => entry is ${propertyData.genericType}Template<${propertyData.genericType}> ? new ${propertyData.genericType}${ClassBuilder.immutable_suffix}.fromMap(entry.mutations) : entry)) : null''';
            } else {
              return '''${propertyData.property.displayName}:${propertyData.property.displayName} != null ? new ${propertyData.asImmutableDisplayName}(${propertyData.property.displayName}) : null''';
            }
          } else return '''${propertyData.property.displayName}:${propertyData.property.displayName}''';
        })
        .join(', ');

    buffer.writeln('factory $className.fromMap(Map<String, dynamic> source) {$values;return new $className($args);}');

    return buffer.toString();
  }

  String writeFromLensFactoryConstructor() {
    final StringBuffer buffer = new StringBuffer();
    final Iterable<String> genericClassTypes = utils.getRecursiveAlphabetizedProperties(element)
        .map(utils.getPropertyData)
        .where((utils.PropertyData propertyData) => propertyData.isGenericClassType)
        .map((utils.PropertyData propertyData) => propertyData.asInterfaceDisplayName);

    if (genericClassTypes.isNotEmpty) {
      buffer.writeln('factory $className.fromLens(void predicate(${element.displayName}Template<${element.displayName}<${genericClassTypes.join(', ')}>, ${genericClassTypes.join(', ')}> template)) {');
      buffer.writeln('final ${element.displayName}Template<${element.displayName}<${genericClassTypes.join(', ')}>, ${genericClassTypes.join(', ')}> template = new ${element.displayName}Template<${element.displayName}<${genericClassTypes.join(', ')}>, ${genericClassTypes.join(', ')}>(null);');
    } else {
      buffer.writeln('factory $className.fromLens(void predicate(${element.displayName}Template<${element.displayName}> template)) {');
      buffer.writeln('final ${element.displayName}Template<${element.displayName}> template = new ${element.displayName}Template<${element.displayName}>(null);');
    }

    buffer.writeln('predicate(template);');
    buffer.writeln('return new $className.fromMap(template.mutations);');
    buffer.writeln('}');

    return buffer.toString();
  }
}