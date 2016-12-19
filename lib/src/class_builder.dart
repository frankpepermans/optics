import 'package:analyzer/dart/element/element.dart';

import 'package:optics/src/element_utils.dart' as utils;

class ClassBuilder {

  final ClassElement element;
  final String className;
  final String suffix;
  final bool isAbstract;
  final bool isPrivate;
  final List<String> implementsList, extendsList;
  final String comment;

  ClassBuilder(ClassElement element, {this.suffix, this.isAbstract, this.isPrivate, this.implementsList: const [], this.extendsList: const [], this.comment}) :
        this.element = element,
        className = '${isPrivate ? '_' : ''}${element.displayName}$suffix';

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

  String writeDeclaration() {
    final StringBuffer buffer = new StringBuffer();
    final String extendsPart = extendsList.join(', ');
    final String implementsPart = implementsList.join(', ');

    buffer.writeln('/// $comment');

    if (isAbstract) buffer.write('abstract ');

    buffer.write('class $className ');

    if (extendsPart.isNotEmpty) buffer.write('extends $extendsPart');

    if (implementsPart.isNotEmpty) buffer.write('implements $implementsPart');

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

    buffer.writeln('$className($args);');

    return buffer.toString();
  }

  String writeBody() => '';

  String finalize() => '}';
}