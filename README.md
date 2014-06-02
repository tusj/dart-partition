dart-partition
==============

Trivial partition function for dart, which splits an iterable into two partitions according to a boolean test

## Usage

```dart
Tuple splits = partition([1,2], (e) => e > 1);
print(splits);
```
outputs
```
([1], [2]);
```
