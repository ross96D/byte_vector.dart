library;

import 'dart:ffi';

import 'src/byte_vector.g.dart' as bv;

class ByteVector implements Finalizable {
  static final Pointer<NativeFunction<Void Function(Pointer<bv.ByteVector>)>>
  _addressByteVectorDestroy = Native.addressOf(bv.bv_destroy);
  static final NativeFinalizer _finalizer = NativeFinalizer(_addressByteVectorDestroy.cast());

  final Pointer<bv.ByteVector> _vector;

  ByteVector.defaults() : _vector = bv.bv_create();

  ByteVector._(this._vector) {
    _finalizer.attach(this, _vector.cast(), detach: this);
  }

  factory ByteVector.empty() {
    final vector = bv.bv_create_with_capacity(0);
    return ByteVector._(vector);
  }

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

  bool _destroyed = false;
  void destroy() {
    if (_destroyed) return;

    _finalizer.detach(this);
    bv.bv_destroy(_vector);
    _destroyed = true;
  }

  void add(int byte) {
    bv.bv_push(_vector, byte);
  }

  void addAll(Iterable<int> bytes) {
    int current = length;
    bv.bv_expand_length(_vector, bytes.length);
    for (final (i, byte) in bytes.indexed) {
      bv.bv_set(_vector, i + current, byte);
    }
  }

  int operator [](int index) {
    return bv.bv_get(_vector, index);
  }

  void operator []=(int index, int value) {
    return bv.bv_set(_vector, index, value);
  }
}
