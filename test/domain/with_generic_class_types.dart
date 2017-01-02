import 'package:optics/optics.dart';

@optics
abstract class WithGenericClassTypes<A, B> extends Comparable<dynamic> {
  A get a;
  B get b;
}