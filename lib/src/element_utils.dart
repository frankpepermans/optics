import 'package:analyzer/dart/element/element.dart';

bool isDartCoreReturnType(PropertyAccessorElement property) => property.returnType.element.library.name.compareTo('dart.core') == 0;

bool isDartCollectionReturnType(PropertyAccessorElement property) => property.returnType.element.library.name.compareTo('dart.collection') == 0;

bool isList(PropertyAccessorElement property) => isDartCoreReturnType(property) && property.returnType.name.compareTo('Iterable') == 0;

List<PropertyAccessorElement> getAlphabetizedProperties(ClassElement element) {
  final List<PropertyAccessorElement> properties = element.accessors
      .where((PropertyAccessorElement property) => property.isPublic)
      .toList(growable: false)
      ..sort((PropertyAccessorElement pA, PropertyAccessorElement pB) => pA.displayName.compareTo(pB.displayName));

  return properties;
}

PropertyData getPropertyData(PropertyAccessorElement property) {
  final bool isCore = isDartCoreReturnType(property);
  final bool isCollection = isList(property);
  final bool isCustomObject = !isCore && !isCollection;

  if (isCustomObject) return new CustomObjectData(property);
  else if (isCollection) return new ListData(property);

  return new DefaultPropertyData(property);
}

abstract class PropertyData {

  PropertyAccessorElement get property;
  String get asImmutableDisplayName;
  String get asMutableDisplayName;
  String get asInterfaceDisplayName;
  String get genericType;

}

class DefaultPropertyData implements PropertyData {

  final PropertyAccessorElement property;
  final String asImmutableDisplayName;
  final String asMutableDisplayName;
  final String asInterfaceDisplayName;
  final String genericType = null;

  DefaultPropertyData(PropertyAccessorElement property) :
        this.property = property,
        this.asImmutableDisplayName = property.returnType.displayName,
        this.asMutableDisplayName = property.returnType.displayName,
        this.asInterfaceDisplayName = property.returnType.displayName;

}

class CustomObjectData implements PropertyData {

  final PropertyAccessorElement property;
  final String asImmutableDisplayName;
  final String asMutableDisplayName;
  final String asInterfaceDisplayName;
  final String genericType = null;

  CustomObjectData(PropertyAccessorElement property) :
        this.property = property,
        this.asImmutableDisplayName = '${property.returnType.displayName}Imm',
        this.asMutableDisplayName = '${property.returnType.displayName}Mut',
        this.asInterfaceDisplayName = property.returnType.displayName;
}

class ListData implements PropertyData {

  final PropertyAccessorElement property;
  final String asImmutableDisplayName;
  final String asMutableDisplayName;
  final String asInterfaceDisplayName;
  final String genericType;

  ListData(PropertyAccessorElement property) :
        this.property = property,
        this.asImmutableDisplayName = ((property.returnType.displayName.compareTo(property.returnType.name) == 0) ? 'UnmodifiableListView' : 'UnmodifiableListView${property.returnType.displayName.substring(property.returnType.name.length)}'),
        this.asMutableDisplayName = ((property.returnType.displayName.compareTo(property.returnType.name) == 0) ? 'List' : 'List${property.returnType.displayName.substring(property.returnType.name.length)}'),
        this.asInterfaceDisplayName = ((property.returnType.displayName.compareTo(property.returnType.name) == 0) ? 'Iterable' : 'Iterable${property.returnType.displayName.substring(property.returnType.name.length)}'),
        this.genericType = ((property.returnType.displayName.compareTo(property.returnType.name) == 0) ? 'dynamic' : property.returnType.displayName.substring(property.returnType.name.length + 1, property.returnType.displayName.length - 1));
}