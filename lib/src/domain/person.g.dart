// GENERATED CODE - DO NOT MODIFY BY HAND

part of domain.person;

// **************************************************************************
// Generator: OpticsGenerator
// Target: abstract class Person
// **************************************************************************

typedef void PersonMutationHandler(PersonMutable template);
Map<String, dynamic> _mappifyPerson(Person value) {
  if (value == null) return null;
  return <String, dynamic>{
    'id': value.id,
    'firstName': value.firstName,
    'lastName': value.lastName,
    'address': _mappifyAddress(value.address),
    'pastAddresses': value.pastAddresses
  };
}

class PersonImpl implements Person {
  final Map<String, dynamic> source;
  String get id => source != null ? source['id'] : null;
  String get firstName => source != null ? source['firstName'] : null;
  String get lastName => source != null ? source['lastName'] : null;
  Address get address {
    if (source != null && source.containsKey('address'))
      return new AddressImpl(source['address']);
    return null;
  }

  Iterable<Address> get pastAddresses =>
      source != null ? source['pastAddresses'] : null;
  PersonImpl(this.source);
  PersonImpl lens(PersonMutationHandler mutationHandler) =>
      new _PersonLens(this, mutationHandler);
  Map<String, dynamic> toJson() => _mappifyPerson(this);
}

class _PersonLens extends PersonImpl {
  final Person root;
  _PersonMutator mutator;
  String get id {
    if (mutator._containsKey('id')) return mutator.id;
    return root.id;
  }

  String get firstName {
    if (mutator._containsKey('firstName')) return mutator.firstName;
    return root.firstName;
  }

  String get lastName {
    if (mutator._containsKey('lastName')) return mutator.lastName;
    return root.lastName;
  }

  Address get address => new _AddressResolver(mutator.address, root.address);
  Iterable<Address> get pastAddresses {
    if (mutator._containsKey('pastAddresses')) return mutator.pastAddresses;
    return root.pastAddresses;
  }

  _PersonLens(Person root, PersonMutationHandler mutationHandler)
      : this.root = root,
        super(null) {
    mutator = new _PersonMutator();
    mutationHandler(mutator);
    mutator.closed = true;
  }
}

class _PersonResolver implements Person {
  final Person primary, secondary;
  String get id {
    if (primary is _PersonMutator) {
      if ((primary as _PersonMutator)._containsKey('id')) return primary.id;
      return secondary?.id;
    }
    return (primary != null) ? primary.id : secondary?.id;
  }

  String get firstName {
    if (primary is _PersonMutator) {
      if ((primary as _PersonMutator)._containsKey('firstName'))
        return primary.firstName;
      return secondary?.firstName;
    }
    return (primary != null) ? primary.firstName : secondary?.firstName;
  }

  String get lastName {
    if (primary is _PersonMutator) {
      if ((primary as _PersonMutator)._containsKey('lastName'))
        return primary.lastName;
      return secondary?.lastName;
    }
    return (primary != null) ? primary.lastName : secondary?.lastName;
  }

  Address get address {
    if (primary is _PersonMutator) {
      if ((primary as _PersonMutator)._containsKey('address'))
        return new _AddressResolver(primary.address, secondary?.address);
      return secondary?.address;
    }
    return (primary != null) ? primary.address : secondary?.address;
  }

  Iterable<Address> get pastAddresses {
    if (primary is _PersonMutator) {
      if ((primary as _PersonMutator)._containsKey('pastAddresses'))
        return primary.pastAddresses;
      return secondary?.pastAddresses;
    }
    return (primary != null) ? primary.pastAddresses : secondary?.pastAddresses;
  }

  _PersonResolver(this.primary, this.secondary);
}

abstract class PersonMutable implements Person {
  set id(String value);
  set firstName(String value);
  set lastName(String value);
  AddressMutable get address;
  set address(Address value);
  set pastAddresses(Iterable<Address> value);
}

class _PersonMutator implements PersonMutable {
  final dynamic parent;
  final Map<String, dynamic> mutations = <String, dynamic>{};
  bool closed = false;
  String get id => mutations['id'];
  set id(String value) => mutations['id'] = value;
  String get firstName => mutations['firstName'];
  set firstName(String value) => mutations['firstName'] = value;
  String get lastName => mutations['lastName'];
  set lastName(String value) => mutations['lastName'] = value;
  AddressMutable get address {
    if (mutations.containsKey('address')) return mutations['address'];
    dynamic P = this;
    while (P.parent != null) P = P.parent;
    if (P.closed) return mutations['address'];
    final _AddressMutator mutator = new _AddressMutator(parent: this);
    mutations['address'] = mutator;
    return mutator;
  }

  set address(Address value) =>
      mutations['address'] = new _AddressMutator.fromImmutable(value);
  Iterable<Address> get pastAddresses => mutations['pastAddresses'];
  set pastAddresses(Iterable<Address> value) =>
      mutations['pastAddresses'] = value;
  _PersonMutator({this.parent: null});
  factory _PersonMutator.fromImmutable(Person value) {
    if (value == null) return null;
    if (value is _PersonMutator) return value;
    return new _PersonMutator()
      ..id = value.id
      ..firstName = value.firstName
      ..lastName = value.lastName
      ..address = (value.address == null)
          ? null
          : new _AddressMutator.fromImmutable(value.address)
      ..pastAddresses = value.pastAddresses;
  }
  bool _containsKey(String key) => mutations.containsKey(key);
}

// **************************************************************************
// Generator: OpticsGenerator
// Target: abstract class Address
// **************************************************************************

typedef void AddressMutationHandler(AddressMutable template);
Map<String, dynamic> _mappifyAddress(Address value) {
  if (value == null) return null;
  return <String, dynamic>{
    'street': value.street,
    'number': value.number,
    'town': value.town,
    'country': value.country,
    'landLord': _mappifyPerson(value.landLord)
  };
}

class AddressImpl implements Address {
  final Map<String, dynamic> source;
  String get street => source != null ? source['street'] : null;
  String get number => source != null ? source['number'] : null;
  String get town => source != null ? source['town'] : null;
  String get country => source != null ? source['country'] : null;
  Person get landLord {
    if (source != null && source.containsKey('landLord'))
      return new PersonImpl(source['landLord']);
    return null;
  }

  AddressImpl(this.source);
  AddressImpl lens(AddressMutationHandler mutationHandler) =>
      new _AddressLens(this, mutationHandler);
  Map<String, dynamic> toJson() => _mappifyAddress(this);
}

class _AddressLens extends AddressImpl {
  final Address root;
  _AddressMutator mutator;
  String get street {
    if (mutator._containsKey('street')) return mutator.street;
    return root.street;
  }

  String get number {
    if (mutator._containsKey('number')) return mutator.number;
    return root.number;
  }

  String get town {
    if (mutator._containsKey('town')) return mutator.town;
    return root.town;
  }

  String get country {
    if (mutator._containsKey('country')) return mutator.country;
    return root.country;
  }

  Person get landLord => new _PersonResolver(mutator.landLord, root.landLord);
  _AddressLens(Address root, AddressMutationHandler mutationHandler)
      : this.root = root,
        super(null) {
    mutator = new _AddressMutator();
    mutationHandler(mutator);
    mutator.closed = true;
  }
}

class _AddressResolver implements Address {
  final Address primary, secondary;
  String get street {
    if (primary is _AddressMutator) {
      if ((primary as _AddressMutator)._containsKey('street'))
        return primary.street;
      return secondary?.street;
    }
    return (primary != null) ? primary.street : secondary?.street;
  }

  String get number {
    if (primary is _AddressMutator) {
      if ((primary as _AddressMutator)._containsKey('number'))
        return primary.number;
      return secondary?.number;
    }
    return (primary != null) ? primary.number : secondary?.number;
  }

  String get town {
    if (primary is _AddressMutator) {
      if ((primary as _AddressMutator)._containsKey('town'))
        return primary.town;
      return secondary?.town;
    }
    return (primary != null) ? primary.town : secondary?.town;
  }

  String get country {
    if (primary is _AddressMutator) {
      if ((primary as _AddressMutator)._containsKey('country'))
        return primary.country;
      return secondary?.country;
    }
    return (primary != null) ? primary.country : secondary?.country;
  }

  Person get landLord {
    if (primary is _AddressMutator) {
      if ((primary as _AddressMutator)._containsKey('landLord'))
        return new _PersonResolver(primary.landLord, secondary?.landLord);
      return secondary?.landLord;
    }
    return (primary != null) ? primary.landLord : secondary?.landLord;
  }

  _AddressResolver(this.primary, this.secondary);
}

abstract class AddressMutable implements Address {
  set street(String value);
  set number(String value);
  set town(String value);
  set country(String value);
  PersonMutable get landLord;
  set landLord(Person value);
}

class _AddressMutator implements AddressMutable {
  final dynamic parent;
  final Map<String, dynamic> mutations = <String, dynamic>{};
  bool closed = false;
  String get street => mutations['street'];
  set street(String value) => mutations['street'] = value;
  String get number => mutations['number'];
  set number(String value) => mutations['number'] = value;
  String get town => mutations['town'];
  set town(String value) => mutations['town'] = value;
  String get country => mutations['country'];
  set country(String value) => mutations['country'] = value;
  PersonMutable get landLord {
    if (mutations.containsKey('landLord')) return mutations['landLord'];
    dynamic P = this;
    while (P.parent != null) P = P.parent;
    if (P.closed) return mutations['landLord'];
    final _PersonMutator mutator = new _PersonMutator(parent: this);
    mutations['landLord'] = mutator;
    return mutator;
  }

  set landLord(Person value) =>
      mutations['landLord'] = new _PersonMutator.fromImmutable(value);
  _AddressMutator({this.parent: null});
  factory _AddressMutator.fromImmutable(Address value) {
    if (value == null) return null;
    if (value is _AddressMutator) return value;
    return new _AddressMutator()
      ..street = value.street
      ..number = value.number
      ..town = value.town
      ..country = value.country
      ..landLord = (value.landLord == null)
          ? null
          : new _PersonMutator.fromImmutable(value.landLord);
  }
  bool _containsKey(String key) => mutations.containsKey(key);
}
