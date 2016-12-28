class Optics {

  const Optics();

}

const Object optics = const Optics();

int compareObjects(dynamic a, dynamic b) {
  if (a is Comparable<dynamic>) return a.compareTo(b);

  return a == b ? 0 : 1;
}

int compareIterables(Iterable<Comparable<dynamic>> a, Iterable<Comparable<dynamic>> b) {
  if (a == null && b == null) return 0;
  if (a == null || b == null) return -1;
  if (a.length != b.length) return -1;

  for (int i=0, len=a.length; i<len; i++) {
    Comparable<dynamic> c = a.elementAt(i), d = b.elementAt(i);

    if (c?.compareTo(d) != 0) return 1;
  }

  return 0;
}