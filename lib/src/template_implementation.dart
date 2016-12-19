import 'package:analyzer/dart/element/element.dart';

import 'package:optics/src/class_builder.dart';

import 'package:optics/src/element_utils.dart' as utils;

class TemplateImplementation extends ClassBuilder {

  TemplateImplementation(ClassElement element) :
        super(element, suffix: 'Template', isAbstract: false, isPrivate: true, implementsList: <String>['${element.displayName}Mut'], comment: 'The template implementation of [${element.displayName}Mut]');

  @override
  String writeClassProperties() {
    final StringBuffer buffer = new StringBuffer();

    buffer.writeln('final ${element.displayName} source;');
    buffer.writeln('final Map<String, dynamic> _mutations = <String, dynamic>{};');

    return buffer.toString();
  }

  @override
  String writeProperty(PropertyAccessorElement property) {
    final StringBuffer buffer = new StringBuffer();

    final utils.PropertyData propertyData = utils.getPropertyData(property);

    if (propertyData is utils.CustomObjectData) {
      buffer.writeln('${propertyData.asMutableDisplayName} get ${property.displayName} {');
      buffer.writeln('''if (_mutations['${property.displayName}'] == null) _mutations['${property.displayName}'] = new _${propertyData.asInterfaceDisplayName}Template(null);''');
      buffer.writeln('''return _mutations['${property.displayName}'];}''');
    } else if (propertyData is utils.ListData) {
      buffer.writeln('${propertyData.asMutableDisplayName} get ${property.displayName} {');
      buffer.writeln('''if (_mutations['${property.displayName}'] == null) _mutations['${property.displayName}'] = <${propertyData.genericType}>[];''');
      buffer.writeln('''if (_mutations['${property.displayName}'].firstWhere((${propertyData.genericType} entry) => entry is! _${propertyData.genericType}Template, orElse: () => null) != null) _mutations['${property.displayName}'] = _mutations['${property.displayName}'].map((${propertyData.genericType} entry) => entry is _${propertyData.genericType}Template ? entry : new _${propertyData.genericType}Template(entry)).toList();''');
      buffer.writeln('''return _mutations['${property.displayName}'];}''');
    } else {
      buffer.writeln('''${propertyData.asMutableDisplayName} get ${property.displayName} => _mutations['${property.displayName}'];''');
    }

    buffer.writeln('''set ${property.displayName}(${propertyData.asInterfaceDisplayName} value) {_mutations['${property.displayName}'] = value;}''');

    return buffer.toString();
  }

  @override
  String writeConstructor() {
    final StringBuffer buffer = new StringBuffer();

    buffer.writeln('${className}(this.source) {');

    final String args = utils.getAlphabetizedProperties(element)
        .map(utils.getPropertyData)
        .map((utils.PropertyData propertyData) {
          if (propertyData is utils.CustomObjectData) return '''_mutations['${propertyData.property.displayName}'] = source?.${propertyData.property.displayName} != null ? new _${propertyData.asInterfaceDisplayName}Template(source.${propertyData.property.displayName}) : null''';
          else if (propertyData is utils.ListData) return '''_mutations['${propertyData.property.displayName}'] = source?.${propertyData.property.displayName} != null ? new ${propertyData.asMutableDisplayName}.from(source.${propertyData.property.displayName}.map((${propertyData.genericType} entry) => new _${propertyData.genericType}Template(entry))) : null''';
          return '''_mutations['${propertyData.property.displayName}'] = source?.${propertyData.property.displayName}''';
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
        .map((String propertyName) => ''''$propertyName':_mutations['$propertyName']''')
        .join(', ');

    buffer.writeln('Map<String, dynamic> _mappify() => <String, dynamic>{$properties};');

    return buffer.toString();
  }
}