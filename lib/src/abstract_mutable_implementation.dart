import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';

import 'package:optics/src/class_builder.dart';

import 'package:optics/src/element_utils.dart' as utils;

class AbstractMutableImplementation extends ClassBuilder {

  AbstractMutableImplementation(ClassElement element) :
        super(element, suffix: 'Mut', isAbstract: true, isPrivate: false, extendsList: <String>[element.displayName], comment: 'The mutable interface for [${element.displayName}]');

  @override
  String writeDeclaration({List<String> genericTypes: const [], Iterable<String> customExtendsList: const [], Iterable<String> customImplementsList: const [], Iterable<String> customMixinsList: const []}) {
    return super.writeDeclaration(customMixinsList: element.allSupertypes
        .map((InterfaceType type) => type.displayName)
        .where((String type) => type.compareTo('Object') != 0)
        .map((String type) => '${type}Mut'));
  }

  @override
  String writeProperty(PropertyAccessorElement property) {
    final StringBuffer buffer = new StringBuffer();

    final utils.PropertyData propertyData = utils.getPropertyData(property);

    buffer.writeln('@override ${propertyData.asMutableDisplayName} get ${property.displayName};');
    buffer.writeln('set ${property.displayName}(${propertyData.asInterfaceDisplayName} value);');

    return buffer.toString();
  }

}