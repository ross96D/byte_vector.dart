import 'dart:io';

import 'package:ffigen/ffigen.dart';

void main() {
  final packageRoot = Platform.script.resolve('../');
  FfiGenerator(
    headers: Headers(
      entryPoints: [packageRoot.resolve('src/byte_vector.h')],
      compilerOptions: [
        // TODO: library paths should not be hardcoded
        '-I/usr/lib/clang/22/include',
        '-I${packageRoot.resolve("native/include").path}',
      ],
    ),
    functions: Functions.includeAll,
    structs: Structs.includeSet({"ByteVector"}),
    output: Output(dartFile: packageRoot.resolve('lib/src/byte_vector.g.dart')),
  ).generate();
}
