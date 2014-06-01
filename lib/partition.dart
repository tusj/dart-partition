library partition;

typedef bool f(e);
Iterable partition(Iterable list, f) {
  var matches = list.where(f);
  var nonMatches = list.toSet().difference(matches.toSet());
  return [matches, nonMatches];
}