import 'package:optics/src/domain/person.dart' show Person;

_PersonMutator get person => new _PersonMutator();

typedef void PersonMutationHandler(PersonMutable person);

Map<String, dynamic> personToMap(Person person) {
  if (person == null) return null;

  return <String, dynamic>{
    'id': person.id,
    'firstName': person.firstName,
    'lastName': person.lastName,
    'isRelatedTo': personToMap(person.isRelatedTo)
  };
}

class PersonImpl implements Person {

  final Map<String, dynamic> source;

  String get id => source != null ? source['id'] : null;

  String get firstName => source != null ? source['firstName'] : null;

  String get lastName => source != null ? source['lastName'] : null;

  Person get isRelatedTo {
    if (source != null && source.containsKey('isRelatedTo')) return new PersonImpl(source['isRelatedTo']);

    return null;
  }

  PersonImpl(this.source);

  PersonImpl lens(PersonMutationHandler mutationHandler) => new _PersonLens(this, mutationHandler);

  Map<String, dynamic> toJson() => personToMap(this);
}

class _PersonLens extends PersonImpl {

  final Person person;
  _PersonMutator mutator;

  String get id {
    if (mutator._containsKey('id')) return mutator.id;

    return person.id;
  }

  String get firstName {
    if (mutator._containsKey('firstName')) return mutator.firstName;

    return person.firstName;
  }

  String get lastName {
    if (mutator._containsKey('lastName')) return mutator.lastName;

    return person.lastName;
  }

  Person get isRelatedTo => new _PersonResolver(mutator.isRelatedTo, person.isRelatedTo);

  _PersonLens(Person person, PersonMutationHandler mutationHandler) :
      this.person = person, super(null) {
    mutator = new _PersonMutator();

    mutationHandler(mutator);

    mutator.closed = true;
  }

}

class _PersonResolver implements Person {

  final Person primary;
  final Person secondary;

  String get id {
    if (primary is _PersonMutator) {
      if ((primary as _PersonMutator)._containsKey('id')) return primary.id;

      return secondary?.id;
    }

    return (primary != null) ? primary.id : secondary?.id;
  }

  String get firstName {
    if (primary is _PersonMutator) {
      if ((primary as _PersonMutator)._containsKey('firstName')) return primary.firstName;

      return secondary?.firstName;
    }

    return (primary != null) ? primary.firstName : secondary?.firstName;
  }

  String get lastName {
    if (primary is _PersonMutator) {
      if ((primary as _PersonMutator)._containsKey('lastName')) return primary.lastName;

      return secondary?.lastName;
    }

    return (primary != null) ? primary.lastName : secondary?.lastName;
  }

  Person get isRelatedTo {
    if (primary is _PersonMutator) {
      if ((primary as _PersonMutator)._containsKey('isRelatedTo')) return new _PersonResolver(primary.isRelatedTo, secondary?.isRelatedTo);

      return secondary?.isRelatedTo;
    }

    return (primary != null) ? primary.isRelatedTo : secondary?.isRelatedTo;
  }

  _PersonResolver(this.primary, this.secondary);

}

abstract class PersonMutable implements Person {

  set id(String value);
  set firstName(String value);
  set lastName(String value);
  set isRelatedTo(Person value);

}

class _PersonMutator implements PersonMutable {

  final _PersonMutator parent;

  bool closed = false;

  final Map<String, dynamic> mutations = <String, dynamic>{};

  String get id => mutations['id'];

  set id(String value) => mutations['id'] = value;

  String get firstName => mutations['firstName'];

  set firstName(String value) => mutations['firstName'] = value;

  String get lastName => mutations['lastName'];

  set lastName(String value) => mutations['lastName'] = value;

  Person get isRelatedTo {
    if (mutations.containsKey('isRelatedTo')) return mutations['isRelatedTo'];

    _PersonMutator P = this;

    while (P.parent != null) P = P.parent;

    if (P.closed) return mutations['isRelatedTo'];

    final _PersonMutator mutator = new _PersonMutator(parent: this);

    mutations['isRelatedTo'] = mutator;

    return mutator;
  }

  set isRelatedTo(Person value) => mutations['isRelatedTo'] = value;

  _PersonMutator({this.parent: null});

  bool _containsKey(String key) => mutations.containsKey(key);

}