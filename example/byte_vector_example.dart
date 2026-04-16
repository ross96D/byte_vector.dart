import 'package:byte_vector/byte_vector.dart';

void main() {
  final bytes = ByteVector.empty();
  bytes.addAll([1,2,3]);
  bytes.add(4);
  bytes.add(5);
  bytes.addAll([6,7,8,9,10,11,12,13,14,15,16,17,18,19,20]);
  print(bytes[0]);
  print(bytes[1]);
  print(bytes[2]);
  print(bytes[3]);
  print(bytes[4]);
  print(bytes[19]);
}
