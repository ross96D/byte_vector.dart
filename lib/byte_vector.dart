/// Support for doing something awesome.
///
/// More dartdocs go here.
library;

import 'dart:ffi';

import 'src/byte_vector.g.dart' as bv;

class ByteVector {
  final Pointer<bv.ByteVector> _vector;

  ByteVector() : _vector = bv.bv_create();

  int get length => _vector.ref.len;

  int get capacity => _vector.ref.cap;

  void add(int byte) {
    bv.bv_push(_vector, byte);
  }

  int operator [](int index) {
    return bv.bv_get(_vector, index);
  }

  void operator []=(int index, int value) {
    return bv.bv_set(_vector, index, value);
  }
}
