import 'dart:async';

import 'package:analyzer/dart/element/element.dart';
import 'package:source_gen/source_gen.dart';

class OpticsGenerator extends Generator {

  @override
  Future<String> generate(Element element, _) async {
    if (element is ClassElement) {
      final ElementAnnotation opticsAnnotation = element.metadata
          .firstWhere((ElementAnnotation annotation) => annotation.element.name.compareTo('optics') == 0, orElse: () => null);

      if (opticsAnnotation != null) {
        final StringBuffer buffer = new StringBuffer();

        _generateTypeDefs(buffer, element);
        _generateJsonSerializer(buffer, element);
        _generateImplClass(buffer, element);
        _generateLens(buffer, element);
        _generateResolver(buffer, element);
        _generateMutableInterface(buffer, element);
        _generateMutator(buffer, element);

        return buffer.toString();
      }
    }

    return null;
  }

  const OpticsGenerator();

  void _generateTypeDefs(StringBuffer buffer, ClassElement element) {
    buffer.write('typedef void ${element.name}MutationHandler(${element.name}Mutable template);');
  }

  void _generateJsonSerializer(StringBuffer buffer, ClassElement element) {
    buffer.write('Map<String, dynamic> _mappify${element.name}(${element.name} value) {');
    buffer.write('if (value == null) return null;');
    buffer.write('return <String, dynamic>{');

    for (int i=0, len=element.accessors.length; i<len; i++) {
      PropertyAccessorElement property = element.accessors[i];

      if (property.returnType.element.library.name.compareTo('dart.core') != 0) {
        buffer.write(''''${property.name}':_mappify${property.returnType.displayName}(value.${property.name})''');
      } else {
        buffer.write(''''${property.name}':value.${property.name}''');
      }

      if (i < len - 1) buffer.write(',');
    }

    buffer.write('};}');
  }

  void _generateImplClass(StringBuffer buffer, ClassElement element) {
    buffer.write('class ${element.name}Impl implements ${element.name} {');
    buffer.write('final Map<String, dynamic> source;');

    element.accessors.forEach((PropertyAccessorElement property) {
      if (property.returnType.element.library.name.compareTo('dart.core') != 0) {
        buffer.write('${property.returnType.displayName} get ${property.name} {');
        buffer.write('''if (source != null && source.containsKey('${property.name}')) return new ${property.returnType.displayName}Impl(source['${property.name}']);''');
        buffer.write('return null;}');
      } else {
        buffer.write('''${property.returnType.displayName} get ${property.name} => source != null ? source['${property.name}'] : null;''');
      }
    });

    buffer.write('${element.name}Impl(this.source);');
    buffer.write('${element.name}Impl lens(${element.name}MutationHandler mutationHandler) => new _${element.name}Lens(this, mutationHandler);');
    buffer.write('Map<String, dynamic> toJson() => _mappify${element.name}(this);');

    buffer.write('}');
  }

  void _generateLens(StringBuffer buffer, ClassElement element) {
    buffer.write('class _${element.name}Lens extends ${element.name}Impl {');
    buffer.write('final ${element.name} root;');
    buffer.write('_${element.name}Mutator mutator;');

    element.accessors.forEach((PropertyAccessorElement property) {
      if (property.returnType.element.library.name.compareTo('dart.core') != 0) {
        buffer.write('${property.returnType.displayName} get ${property.name} => new _${property.returnType.displayName}Resolver(mutator.${property.name}, root.${property.name});');
      } else {
        buffer.write('${property.returnType.displayName} get ${property.name} {');
        buffer.write('''if (mutator._containsKey('${property.name}')) return mutator.${property.name};''');
        buffer.write('return root.${property.name};}');
      }
    });

    buffer.write('_${element.name}Lens(${element.name} root, ${element.name}MutationHandler mutationHandler) :');
    buffer.write('this.root = root, super(null) {');
    buffer.write('mutator = new _${element.name}Mutator();');
    buffer.write('mutationHandler(mutator);');
    buffer.write('mutator.closed = true;}}');
  }

  void _generateResolver(StringBuffer buffer, ClassElement element) {
    buffer.write('class _${element.name}Resolver implements ${element.name} {');
    buffer.write('final ${element.name} primary, secondary;');

    element.accessors.forEach((PropertyAccessorElement property) {
      if (property.returnType.element.library.name.compareTo('dart.core') != 0) {
        buffer.write('${property.returnType.displayName} get ${property.name} {');
        buffer.write('if (primary is _${element.name}Mutator) {');
        buffer.write('''if ((primary as _${element.name}Mutator)._containsKey('${property.name}')) return new _${property.returnType.displayName}Resolver(primary.${property.name}, secondary?.${property.name});''');
        buffer.write('return secondary?.${property.name};}');
        buffer.write('return (primary != null) ? primary.${property.name} : secondary?.${property.name};}');
      } else {
        buffer.write('${property.returnType.displayName} get ${property.name} {');
        buffer.write('if (primary is _${element.name}Mutator) {');
        buffer.write('''if ((primary as _${element.name}Mutator)._containsKey('${property.name}')) return primary.${property.name};''');
        buffer.write('return secondary?.${property.name};}');
        buffer.write('return (primary != null) ? primary.${property.name} : secondary?.${property.name};}');
      }
    });

    buffer.write('_${element.name}Resolver(this.primary, this.secondary);}');
  }

  void _generateMutableInterface(StringBuffer buffer, ClassElement element) {
    buffer.write('abstract class ${element.name}Mutable implements ${element.name} {');

    element.accessors.forEach((PropertyAccessorElement property) {
      if (property.returnType.element.library.name.compareTo('dart.core') != 0) {
        buffer.write('${property.returnType.displayName}Mutable get ${property.name};');
        buffer.write('set ${property.name}(${property.returnType.displayName} value);');
      } else {
        buffer.write('set ${property.name}(${property.returnType.displayName} value);');
      }
    });

    buffer.write('}');
  }

  void _generateMutator(StringBuffer buffer, ClassElement element) {
    buffer.write('class _${element.name}Mutator implements ${element.name}Mutable {');
    buffer.write('final dynamic parent;');
    buffer.write('final Map<String, dynamic> mutations = <String, dynamic>{};');
    buffer.write('bool closed = false;');

    element.accessors.forEach((PropertyAccessorElement property) {
      if (property.returnType.element.library.name.compareTo('dart.core') != 0) {
        buffer.write('${property.returnType.displayName}Mutable get ${property.name} {');
        buffer.write('''if (mutations.containsKey('${property.name}')) return mutations['${property.name}'];''');
        buffer.write('dynamic P = this;');
        buffer.write('while (P.parent != null) P = P.parent;');
        buffer.write('''if (P.closed) return mutations['${property.name}'];''');
        buffer.write('final _${property.returnType.displayName}Mutator mutator = new _${property.returnType.displayName}Mutator(parent: this);');
        buffer.write('''mutations['${property.name}'] = mutator;''');
        buffer.write('return mutator;}');
        buffer.write('''set ${property.name}(${property.returnType.displayName} value) => mutations['${property.name}'] = new _${property.returnType.displayName}Mutator.fromImmutable(value);''');
      } else {
        buffer.write('''${property.returnType.displayName} get ${property.name} => mutations['${property.name}'];''');
        buffer.write('''set ${property.name}(${property.returnType.displayName} value) => mutations['${property.name}'] = value;''');
      }
    });

    buffer.write('_${element.name}Mutator({this.parent: null});');

    buffer.write('factory _${element.name}Mutator.fromImmutable(${element.name} value) {');
    buffer.write('if (value == null) return null;');
    buffer.write('if (value is _${element.name}Mutator) return value;');
    buffer.write('return new _${element.name}Mutator()');

    element.accessors.forEach((PropertyAccessorElement property) {
      if (property.returnType.element.library.name.compareTo('dart.core') != 0) {
        buffer.write('..${property.name} = (value.${property.name} == null) ? null : new _${property.returnType.displayName}Mutator.fromImmutable(value.${property.name})');
      } else {
        buffer.write('..${property.name} = value.${property.name}');
      }
    });

    buffer.write(';}bool _containsKey(String key) => mutations.containsKey(key);}');
  }

}