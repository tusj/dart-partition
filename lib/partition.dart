library partition;

import 'package:tuple/tuple.dart';

typedef bool f(e);
Tuple<Iterable, Iterable> partition_set_slow(Iterable list, f) {
  var matches = list.where(f);
  var nonMatches = list.toSet().difference(matches.toSet());
  return new Tuple(matches, nonMatches);
}

// quick version
Tuple<Iterable, Iterable> partition(Iterable list, f) {
  var matches = [];
  var nonMatches = [];
  list.forEach((e) {
    if (f(e)) {
      matches.add(e);
    } else {
      nonMatches.add(e);
    }
  });
  return new Tuple(matches, nonMatches);
}