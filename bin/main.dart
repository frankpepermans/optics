import 'dart:convert';

import 'package:optics/optics.dart';

// some dummy data to create a Person with
const String dataRaw = '{"id":"1","firstName":"John","lastName":"Doe","address":{"street":"Sesame Street","number":"1A","town":"Antwerp","country":"Belgium"}}';

main(List<String> args) {
  _unmodified();
  _modifyStepped();
  _modifyBatched();
  _modifyDeepNested();
  _reference();
}

/*
 * NOTE:
 * Below functionality wouldn't be possible without source_gen
 * The only thing the user would have to manually create, it the interface, for example:
 *
 *
    abstract class Person {

      String get id, firstName, lastName;

      Person get isRelatedTo;
    }
 *
 */

/*
 * Basic object example,
 * no lensing,
 * just deserializing from JSON to immutable Person / PersonImpl
 */
void _unmodified() {
  final Person subject = new PersonImpl(JSON.decode(dataRaw));

  _prettyPrint(subject);

  /*
      {
          "id": "1",
          "firstName": "John",
          "lastName": "Doe",
          "isRelatedTo": {
              "id": "2",
              "firstName": "Jane",
              "lastName": "Smith",
              "isRelatedTo": null
          }
      }
   */
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
      .lens((template) => template.address.street = 'Race')
      .lens((template) => template.address.number = '23');

  _prettyPrint(subject);

  /*
      {
          "id": "1",
          "firstName": "Billie",
          "lastName": "The Kid",
          "isRelatedTo": {
              "id": "2",
              "firstName": "Calamity",
              "lastName": "Jane",
              "isRelatedTo": {
                  "id": null,
                  "firstName": "Pistol",
                  "lastName": "Pete",
                  "isRelatedTo": null
              }
          }
      }
   */
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
        template.address.street = 'Race';
        template.address.number = '23';
      });

  _prettyPrint(subject);

  /*
      {
          "id": "1",
          "firstName": "Billie",
          "lastName": "The Kid",
          "isRelatedTo": {
              "id": "2",
              "firstName": "Calamity",
              "lastName": "Jane",
              "isRelatedTo": {
                  "id": null,
                  "firstName": "Pistol",
                  "lastName": "Pete",
                  "isRelatedTo": null
              }
          }
      }
   */
}

/*
 * Example to showcase how you can set a deeply nested property, even if this path would be null at some point in the original object
 */
void _modifyDeepNested() {
  PersonImpl subject = new PersonImpl(JSON.decode(dataRaw));

  subject = subject
      .lens((template) => template.address.landLord.address.landLord.address.landLord.address.street = 'far far away');

  _prettyPrint(subject);

  /*
    {
          "id": "1",
          "firstName": "John",
          "lastName": "Doe",
          "isRelatedTo": {
              "id": "2",
              "firstName": "Jane",
              "lastName": "Smith",
              "isRelatedTo": {
                  "id": null,
                  "firstName": null,
                  "lastName": null,
                  "isRelatedTo": {
                      "id": null,
                      "firstName": null,
                      "lastName": null,
                      "isRelatedTo": {
                          "id": null,
                          "firstName": null,
                          "lastName": null,
                          "isRelatedTo": {
                              "id": null,
                              "firstName": null,
                              "lastName": null,
                              "isRelatedTo": {
                                  "id": null,
                                  "firstName": null,
                                  "lastName": null,
                                  "isRelatedTo": {
                                      "id": null,
                                      "firstName": "auntie Hattie",
                                      "lastName": null,
                                      "isRelatedTo": null
                                  }
                              }
                          }
                      }
                  }
              }
          }
      }
   */
}

/*
 * Example to show you can simply use a Person object itself as a valid template setter value,
 * In this case a self-reference is created
 */
void _reference() {
  PersonImpl subject = new PersonImpl(JSON.decode(dataRaw));

  subject = subject
      .lens((template) => template.address.landLord = subject);

  _prettyPrint(subject);

  /*
    {
        "id": "1",
        "firstName": "John",
        "lastName": "Doe",
        "isRelatedTo": {
            "id": "2",
            "firstName": "Jane",
            "lastName": "Smith",
            "isRelatedTo": {
                "id": "1",
                "firstName": "John",
                "lastName": "Doe",
                "isRelatedTo": {
                    "id": "2",
                    "firstName": "Jane",
                    "lastName": "Smith",
                    "isRelatedTo": null
                }
            }
        }
    }
   */
}

// pretty JSON printer
void _prettyPrint(PersonImpl subject) => print(new JsonEncoder.withIndent('    ').convert(subject));
