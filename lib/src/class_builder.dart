import 'package:analyzer/dart/element/element.dart';

import 'package:optics/src/element_utils.dart' as utils;

class ClassBuilder {

  static final String immutable_suffix = 'Immutable';
  static final String mutable_suffix = 'Mutable';

  final ClassElement element;
  final String className;
  final String suffix;
  final bool isAbstract;
  final bool isPrivate;
  final List<String> implementsList, extendsList;
  final String comment;
  final bool isSubClass;

  ClassBuilder(ClassElement element, {this.suffix, this.isAbstract, this.isPrivate, this.implementsList: const [], this.extendsList: const [], this.comment}) :
        this.element = element,
        className = '${isPrivate ? '_' : ''}${element.displayName}$suffix',
        isSubClass = element.allSupertypes.length > 1;

  String write() {
    final StringBuffer buffer = new StringBuffer();

    buffer.writeln(writeDeclaration());

    buffer.writeln(writeClassProperties());

    for (int i=0, len=element.accessors.length; i<len; i++) {
      PropertyAccessorElement property = element.accessors[i];

      if (property.isPublic) buffer.writeln(writeProperty(property));
    }

    if (!isAbstract) buffer.writeln(writeConstructor());

    buffer.writeln(writeBody());

    buffer.writeln(finalize());

    return buffer.toString();
  }

  String writeDeclaration({List<String> genericTypes: const [], Iterable<String> customExtendsList: const [], Iterable<String> customImplementsList: const [], Iterable<String> customMixinsList: const []}) {
    final StringBuffer buffer = new StringBuffer();
    final List<String> allExtends = new List<String>()..addAll(extendsList)..addAll(customExtendsList);
    final List<String> allImplements = new List<String>()..addAll(implementsList)..addAll(customImplementsList);
    final List<String> allMixins = new List<String>()..addAll(customMixinsList)..addAll(extendsList.length > 1 ? extendsList.sublist(1) : const []);
    final String extendsPart = allExtends.isNotEmpty ? allExtends.first : '';
    final String implementsPart = allImplements.join(', ');

    buffer.writeln('/// $comment');

    if (isAbstract) buffer.write('abstract ');

    if (genericTypes.isEmpty) buffer.write('class $className ');
    else buffer.write('class $className<${genericTypes.join(', ')}> ');

    if (extendsPart.isNotEmpty) buffer.write(' extends $extendsPart');

    if (implementsPart.isNotEmpty) buffer.write(' implements $implementsPart');

    if (allMixins.isNotEmpty) buffer.write(' with ${allMixins.join(', ')}');

    buffer.write('{');

    return buffer.toString();
  }

  String writeClassProperties() => '';

  String writeProperty(PropertyAccessorElement property) {
    if (extendsList.isEmpty && implementsList.isEmpty) return 'final ${property.returnType.displayName} ${property.displayName};';

    return '@override final ${property.returnType.displayName} ${property.displayName};';
  }

  String writeConstructor() {
    final StringBuffer buffer = new StringBuffer();
    final String args = utils.getAlphabetizedProperties(element)
        .map((PropertyAccessorElement property) => property.displayName)
        .map((String propertyName) => 'this.$propertyName')
        .join(', ');

    buffer.writeln('$className({$args});');

    return buffer.toString();
  }

  String writeBody() => '';

  String finalize() => '}';
}