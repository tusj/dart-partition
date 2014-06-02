import 'package:benchmark_harness/benchmark_harness.dart';
import 'package:partition/partition.dart' as p;
import 'dart:math';
import 'package:tuple/tuple.dart';

abstract class PartitionBenchmarkBase extends BenchmarkBase {
  
  PartitionBenchmarkBase(String name): super(name);
  
  static bool _isSetup = false;
  static final _data = [];
  final _res = [];
  static const int _dataSize = 100000;
  static const _maxInt = 1 << 32 - 1;

  Tuple<Iterable, Iterable> partition(Iterable it, Function f);
  
  @override
  void run() {
    var res = partition(_data, () {
      var split = _maxInt / 2;
      return (e) => e > split;
    }());
    _res.add(res.first.length);
    _res.add(res.second.length);
  }
  
  @override
  void setup() {
    if (_isSetup) {
      return;
    }
    _isSetup = true;
    var r = new Random(new DateTime.now().millisecond);
    _data.addAll(new Iterable.generate(_dataSize, (_) => r.nextInt(_maxInt)));
  }
  
  @override
  void teardown() {
    print("${_res.first}, ${_res.last}: ${_res.first + _res.last}");
  }
}

class FastPartitionBenchmark extends PartitionBenchmarkBase {
  FastPartitionBenchmark(): super("Fast partition");
  @override
  partition(it, f) => p.partition(it, f);
  
}

class SlowPartitionBenchmark extends PartitionBenchmarkBase {
  SlowPartitionBenchmark(): super("Slow partition");
  @override
  partition(it, f) => p.partition_set_slow(it, f);
}

void main() {
  new SlowPartitionBenchmark().report();
  new FastPartitionBenchmark().report();
}