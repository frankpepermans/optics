import 'package:analyzer/dart/element/element.dart';

import 'package:optics/src/class_builder.dart';

import 'package:optics/src/element_utils.dart' as utils;

class PropertiesImplementation extends ClassBuilder {

  PropertiesImplementation(ClassElement element) :
        super(element, suffix: 'Props', isAbstract: true, isPrivate: false, extendsList: <String>[], comment: 'All public properties for [${element.displayName}]');

  @override
  String writeProperty(PropertyAccessorElement property) {
    final StringBuffer buffer = new StringBuffer();

    final utils.PropertyData propertyData = utils.getPropertyData(property);

    buffer.writeln('''static const String ${property.displayName} = '${property.displayName}';''');

    return buffer.toString();
  }

}