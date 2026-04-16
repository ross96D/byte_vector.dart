/// Support for doing something awesome.
///
/// More dartdocs go here.
library;

import 'dart:ffi';

import 'src/byte_vector.g.dart' as bv;

class ByteVector {
  final Pointer<bv.ByteVector> _vector;

  ByteVector.defaults() : _vector = bv.bv_create();

  ByteVector.empty() : _vector = bv.bv_create_with_capacity(0);

  ByteVector._(this._vector);

  factory ByteVector.fromByteList(List<int> bytes) {
    final vector = bv.bv_create_with_capacity((bytes.length * 1.5).ceil());
    vector.ref.len = bytes.length;
    for (final (i, byte) in bytes.indexed) {
      bv.bv_set(vector, i, byte);
    }
    return ByteVector._(vector);
  }

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
