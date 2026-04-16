import 'package:byte_vector/byte_vector.dart';

void main() {
  final bytes = ByteVector();
  bytes.add(1);
  bytes.add(2);
  bytes.add(3);
  print(bytes[0]);
  print(bytes[1]);
  print(bytes[2]);
}
