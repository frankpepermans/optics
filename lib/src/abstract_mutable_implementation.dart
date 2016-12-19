import 'package:analyzer/dart/element/element.dart';

import 'package:optics/src/class_builder.dart';

import 'package:optics/src/element_utils.dart' as utils;

class AbstractMutableImplementation extends ClassBuilder {

  AbstractMutableImplementation(ClassElement element) :
        super(element, suffix: 'Mut', isAbstract: true, isPrivate: false, extendsList: <String>[element.displayName], comment: 'The mutable interface for [${element.displayName}]');

  @override
  String writeProperty(PropertyAccessorElement property) {
    final StringBuffer buffer = new StringBuffer();

    final utils.PropertyData propertyData = utils.getPropertyData(property);

    buffer.writeln('${propertyData.asMutableDisplayName} get ${property.displayName};');
    buffer.writeln('set ${property.displayName}(${propertyData.asInterfaceDisplayName} value);');

    return buffer.toString();
  }

}