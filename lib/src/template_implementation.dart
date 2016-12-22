import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';

import 'package:optics/src/class_builder.dart';

import 'package:optics/src/element_utils.dart' as utils;

class TemplateImplementation extends ClassBuilder {

  TemplateImplementation(ClassElement element) :
        super(element, suffix: 'Template', isAbstract: false, isPrivate: false, implementsList: <String>['${element.displayName}${ClassBuilder.mutable_suffix}'], comment: 'The template implementation of [${element.displayName}${ClassBuilder.mutable_suffix}]');

  @override
  String writeDeclaration({List<String> genericTypes: const [], Iterable<String> customExtendsList: const [], Iterable<String> customImplementsList: const [], Iterable<String> customMixinsList: const []}) {
    return super.writeDeclaration(genericTypes: <String>['T extends ${element.displayName}'], customExtendsList: element.allSupertypes
        .map((InterfaceType type) => type.displayName)
        .where((String type) => type.compareTo('Object') != 0)
        .map((String type) => '${type}Template<T>'));
  }

  @override
  String writeClassProperties() {
    final StringBuffer buffer = new StringBuffer();

    if (!isSubClass) {
      buffer.writeln('final T source;');
      buffer.writeln('final Map<String, dynamic> mutations = <String, dynamic>{};');
    }

    return buffer.toString();
  }

  @override
  String writeProperty(PropertyAccessorElement property) {
    final StringBuffer buffer = new StringBuffer();

    final utils.PropertyData propertyData = utils.getPropertyData(property);

    if (propertyData is utils.CustomObjectData) {
      buffer.writeln('@override ${propertyData.asMutableDisplayName} get ${property.displayName} {');
      buffer.writeln('''if (mutations['${property.displayName}'] == null) mutations['${property.displayName}'] = new ${propertyData.asInterfaceDisplayName}Template<${propertyData.asInterfaceDisplayName}>(null);''');
      buffer.writeln('''return mutations['${property.displayName}'];}''');
    } else if (propertyData is utils.ListData) {
      buffer.writeln('@override ${propertyData.asMutableDisplayName} get ${property.displayName} {');
      buffer.writeln('''if (mutations['${property.displayName}'] == null) mutations['${property.displayName}'] = <${propertyData.genericType}>[];''');
      buffer.writeln('''if (mutations['${property.displayName}'].firstWhere((${propertyData.genericType} entry) => entry is! ${propertyData.genericType}Template<${propertyData.genericType}>, orElse: () => null) != null) mutations['${property.displayName}'] = mutations['${property.displayName}'].map((${propertyData.genericType} entry) => entry is ${propertyData.genericType}Template<${propertyData.genericType}> ? entry : new ${propertyData.genericType}Template<${propertyData.genericType}>(entry)).toList();''');
      buffer.writeln('''return mutations['${property.displayName}'];}''');
    } else {
      buffer.writeln('''@override ${propertyData.asMutableDisplayName} get ${property.displayName} => mutations['${property.displayName}'];''');
    }

    buffer.writeln('''@override set ${property.displayName}(${propertyData.asInterfaceDisplayName} value) {mutations['${property.displayName}'] = value;}''');

    return buffer.toString();
  }

  @override
  String writeConstructor() {
    final StringBuffer buffer = new StringBuffer();

    if (isSubClass) buffer.writeln('$className(T source) : super(source) {');
    else buffer.writeln('$className(this.source) {');

    final String args = utils.getAlphabetizedProperties(element)
        .map(utils.getPropertyData)
        .map((utils.PropertyData propertyData) {
          if (propertyData is utils.CustomObjectData) return '''mutations['${propertyData.property.displayName}'] = source?.${propertyData.property.displayName} != null ? new ${propertyData.asInterfaceDisplayName}Template<${propertyData.asInterfaceDisplayName}>(source.${propertyData.property.displayName}) : null''';
          else if (propertyData is utils.ListData) return '''mutations['${propertyData.property.displayName}'] = source?.${propertyData.property.displayName} != null ? new ${propertyData.asMutableDisplayName}.from(source.${propertyData.property.displayName}.map((${propertyData.genericType} entry) => new ${propertyData.genericType}Template<${propertyData.genericType}>(entry))) : null''';
          return '''mutations['${propertyData.property.displayName}'] = source?.${propertyData.property.displayName}''';
        })
        .join(';');

    buffer.writeln(args);

    buffer.writeln(';}');

    return buffer.toString();
  }

  @override
  String writeBody() {
    final StringBuffer buffer = new StringBuffer();
    final String properties = utils.getAlphabetizedProperties(element)
        .map((PropertyAccessorElement property) => property.displayName)
        .map((String propertyName) => ''''$propertyName':mutations['$propertyName']''')
        .join(', ');

    if (isSubClass) buffer.writeln('@override Map<String, dynamic> toJson() => super.toJson()..addAll(<String, dynamic>{$properties});');
    else buffer.writeln('Map<String, dynamic> toJson() => <String, dynamic>{$properties};');

    return buffer.toString();
  }
}