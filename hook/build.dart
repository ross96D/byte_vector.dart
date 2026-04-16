import 'package:hooks/hooks.dart';
import 'package:logging/logging.dart';
import 'package:native_toolchain_c/native_toolchain_c.dart';
import 'dart:io';

void main(List<String> args) async {
  await build(args, (input, output) async {
    final packageName = input.packageName;
    // throw input.config.;
    final cbuilder = CBuilder.library(
      name: packageName,
      assetName: 'src/byte_vector.g.dart',
      sources: ['src/byte_vector.c'],
      linkModePreference: .dynamic,
    );
    final logger = Logger.detached('CBuilder');
    logger.level = .WARNING;
    logger.onRecord.listen((record) {
      if (record.message.contains("no vswhere.exe")) {
        return;
      }
      stderr.writeln("${record.level}: ${record.message}");
      if (record.error != null) {
        stderr.writeln(record.error);
      }
      if (record.stackTrace != null) {
        stderr.writeln(record.stackTrace);
      }
    });
    await cbuilder.run(input: input, output: output, routing: [ToAppBundle()], logger: logger);
  });
}
