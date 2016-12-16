import 'dart:convert';

import 'package:optics/optics.dart';

// some dummy data to create a Person with
const String dataRaw = '{"id":"1","firstName":"John","lastName":"Doe","isRelatedTo":{"id":"2","firstName":"Jane","lastName":"Smith"}}';

main(List<String> args) {
  _unmodified();
  _modifyStepped();
  _modifyBatched();
  _modifyDeepNested();
  _reference();
}

/*
 * Basic object example,
 * no lensing,
 * just deserializing from JSON to immutable Person / PersonImpl
 */
void _unmodified() {
  final Person subject = new PersonImpl(JSON.decode(dataRaw));

  _prettyPrint(subject);
}

/*
 * Cascading lens example
 *
 * subject is immutable and we want to obtain a new immutable subject,
 * with a few property updates:
 *
 * The lens method takes a handler in which you can define the mutations,
 * it returns a new immutable object.
 *
 * With this handler:
 * template is a temporary object, which only exists withing the lens' function scope.
 * It has no initial values, you can only use it to set new property values.
 * You may safely use the dot notation to set nested properties, nested objects are never null,
 * instead they are always just a new clean template.
 *
 * The returned immutable object is the result of layering the template changes over the object that existed before the lens:
 * If the template has set a new property value => use this value
 * If the template didn't set a certain property => use the value found in the old immutable object
 */
void _modifyStepped() {
  PersonImpl subject = new PersonImpl(JSON.decode(dataRaw));

  subject = subject
      .lens((template) => template.firstName = 'Billie')
      .lens((template) => template.lastName = 'The Kid')
      .lens((template) => template.isRelatedTo.firstName = 'Calamity')
      .lens((template) => template.isRelatedTo.lastName = 'Jane')
      .lens((template) => template.isRelatedTo.isRelatedTo.firstName = 'Pistol')
      .lens((template) => template.isRelatedTo.isRelatedTo.lastName = 'Pete');

  _prettyPrint(subject);
}

/*
 * Same as above example,
 * in this case we simply do one lens with many property updates.
 * The result is identical to the above example
 */
void _modifyBatched() {
  PersonImpl subject = new PersonImpl(JSON.decode(dataRaw));

  subject = subject
      .lens((template) {
        template.firstName = 'Billie';
        template.lastName = 'The Kid';
        template.isRelatedTo.firstName = 'Calamity';
        template.isRelatedTo.lastName = 'Jane';
        template.isRelatedTo.isRelatedTo.firstName = 'Pistol';
        template.isRelatedTo.isRelatedTo.lastName = 'Pete';
      });

  _prettyPrint(subject);
}

/*
 * Example to showcase how you can set a deeply nested property, even if this path would be null at some point in the original object
 */
void _modifyDeepNested() {
  PersonImpl subject = new PersonImpl(JSON.decode(dataRaw));

  subject = subject
      .lens((template) => template.isRelatedTo.isRelatedTo.isRelatedTo.isRelatedTo.isRelatedTo.isRelatedTo.isRelatedTo.firstName = 'auntie Hattie');

  _prettyPrint(subject);
}

/*
 * Example to show you can simply use a Person object itself as a valid template setter value,
 * In this case a self-reference is created
 */
void _reference() {
  PersonImpl subject = new PersonImpl(JSON.decode(dataRaw));

  subject = subject
      .lens((template) => template.isRelatedTo.isRelatedTo = subject);

  _prettyPrint(subject);
}

// pretty JSON printer
void _prettyPrint(PersonImpl subject) => print(new JsonEncoder.withIndent('    ').convert(subject));