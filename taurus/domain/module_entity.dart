import 'package:optics/optics.dart';

@optics
abstract class ModuleEntity {

  String id;
  int version;
  BasedOn basedOn;
  String type;
  String language;

}