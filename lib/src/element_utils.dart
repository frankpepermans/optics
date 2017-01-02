import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';

import 'package:optics/src/class_builder.dart';

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

List<PropertyAccessorElement> getRecursiveAlphabetizedProperties(ClassElement element, {List<PropertyAccessorElement> properties}) {
  properties ??= <PropertyAccessorElement>[];

  properties.addAll(element.accessors
      .where((PropertyAccessorElement property) => property.isPublic)
      .toList(growable: false)
    ..sort((PropertyAccessorElement pA, PropertyAccessorElement pB) => pA.displayName.compareTo(pB.displayName)));

  element.allSupertypes
      .where((InterfaceType interfaceType) => interfaceType.displayName.compareTo('Object') != 0)
      .forEach((InterfaceType interfaceType) => getRecursiveAlphabetizedProperties(interfaceType.element, properties: properties));

  return properties.toSet().toList();
}

PropertyData getPropertyData(PropertyAccessorElement property) {
  final bool isVoid = property.returnType.displayName.compareTo('dynamic') == 0;
  final bool isCore = isVoid ? true : isDartCoreReturnType(property);
  final bool isCollection = isVoid ? false : isList(property);
  final bool isGenericClassType = property.returnType.element.kind.displayName.compareTo('type parameter') == 0;
  final bool isCustomObject = !isGenericClassType && !isCore && !isCollection;

  if (isCustomObject) return new CustomObjectData(property);
  else if (isCollection) return new ListData(property);

  return new DefaultPropertyData(property, isGenericClassType);
}

List<Set<String>> getImports(ClassElement element) {
  final List<ClassElement> hierarchy = new List<ClassElement>()
    ..add(element)
    ..addAll(element.allSupertypes.map((InterfaceType type) => type.element));
  final Set<String> hierarchyImports = new Set<String>();
  final Set<String> packageImports = new Set<String>();

  hierarchy.forEach((ClassElement element) {
    new RegExp(r'''import ['"]{1}([^'"]+)['"]{1};''')
        .allMatches(element.enclosingElement.source.contents.data)
        .forEach((Match match) {
      if (!match.group(1).startsWith('package:')) {
        final List<String> parts = match.group(1).split('.')
          ..removeLast()
          ..add('g.dart');
        hierarchyImports.add('''import '${parts.join('.')}';''');
      } else {
        packageImports.add(match.group(0));
      }
    });
  });

  return <Set<String>>[hierarchyImports, packageImports];
}

bool isCustomObject(ClassElement element, String type) {
  return type != 'String' && type != 'num' && type != 'int' && type != 'double' && type != 'DateTime' && type != 'bool' && type != 'Object' && type != 'dynamic';
  /*final RegExp regExp = new RegExp(r'''['"]{1}([\w]+).g.dart['"]{1}''');
  final List<Set<String>> imports = getImports(element);
  final Set<String> allImports = new Set<String>()
    ..addAll(imports.first)
    ..addAll(imports.last);

  return allImports.firstWhere((String importLine) => regExp.firstMatch(importLine)?.group(1)?.toLowerCase() == type.toLowerCase(), orElse: () => null) != null;*/
}

abstract class PropertyData {

  PropertyAccessorElement get property;
  String get asImmutableDisplayName;
  String get asMutableDisplayName;
  String get asInterfaceDisplayName;
  String get genericType;
  bool get isGenericClassType;

}

class DefaultPropertyData implements PropertyData {

  @override final PropertyAccessorElement property;
  @override final String asImmutableDisplayName;
  @override final String asMutableDisplayName;
  @override final String asInterfaceDisplayName;
  @override final String genericType = null;
  @override final bool isGenericClassType;

  DefaultPropertyData(PropertyAccessorElement property, bool isGenericClassType) :
        this.property = property,
        this.asImmutableDisplayName = property.returnType.displayName,
        this.asMutableDisplayName = property.returnType.displayName,
        this.asInterfaceDisplayName = property.returnType.displayName,
        this.isGenericClassType = isGenericClassType;

}

class CustomObjectData implements PropertyData {

  @override final PropertyAccessorElement property;
  @override final String asImmutableDisplayName;
  @override final String asMutableDisplayName;
  @override final String asInterfaceDisplayName;
  @override final String genericType = null;
  @override final bool isGenericClassType = false;

  CustomObjectData(PropertyAccessorElement property) :
        this.property = property,
        this.asImmutableDisplayName = '${property.returnType.displayName}${ClassBuilder.immutable_suffix}',
        this.asMutableDisplayName = '${property.returnType.displayName}${ClassBuilder.mutable_suffix}',
        this.asInterfaceDisplayName = property.returnType.displayName;
}

class ListData implements PropertyData {

  @override final PropertyAccessorElement property;
  @override final String asImmutableDisplayName;
  @override final String asMutableDisplayName;
  @override final String asInterfaceDisplayName;
  @override final String genericType;
  @override final bool isGenericClassType = false;

  ListData(PropertyAccessorElement property) :
        this.property = property,
        this.asImmutableDisplayName = ((property.returnType.displayName.compareTo(property.returnType.name) == 0) ? 'UnmodifiableListView' : 'UnmodifiableListView${property.returnType.displayName.substring(property.returnType.name.length)}'),
        this.asMutableDisplayName = ((property.returnType.displayName.compareTo(property.returnType.name) == 0) ? 'List' : 'List${property.returnType.displayName.substring(property.returnType.name.length)}'),
        this.asInterfaceDisplayName = ((property.returnType.displayName.compareTo(property.returnType.name) == 0) ? 'Iterable' : 'Iterable${property.returnType.displayName.substring(property.returnType.name.length)}'),
        this.genericType = ((property.returnType.displayName.compareTo(property.returnType.name) == 0) ? 'dynamic' : property.returnType.displayName.substring(property.returnType.name.length + 1, property.returnType.displayName.length - 1));
}