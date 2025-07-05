import 'dart:io';
import 'package:webserver/goodies/api_extension.dart';
import 'package:webserver/update_server/fda_drug_code.dart';
import 'package:webserver/update_server/icd10_dhs.dart';
import 'package:webserver/update_server/loinc.dart';
import 'package:webserver/update_server/variables.dart';
import 'package:webserver/webserver.dart';
import 'package:args/args.dart';

Future<void> main(List<String> arguments) async {
  // Parse command line arguments for host and port

  bool updateDatabase = false;

  final parser = ArgParser();
  parser.addOption('host', defaultsTo: NetWorkConfig.instance.host);
  parser.addOption('port', defaultsTo: NetWorkConfig.instance.port.toString());
  parser.addFlag('update', defaultsTo: updateDatabase);

  final argResults = parser.parse(arguments);
  NetWorkConfig.instance.host = argResults['host'] as String? ?? 'localhost';
  NetWorkConfig.instance.port = int.tryParse(argResults['port'] as String? ?? '8080') ?? 8080;
  updateDatabase = argResults['update'] as bool? ?? false;

  if (updateDatabase) {
    await updateCurrentDatabase();
  }

  try {
    final server = WebServer();
    await server.start(host: NetWorkConfig.instance.host, port: NetWorkConfig.instance.port);

    // Keep the server running until interrupted
    await ProcessSignal.sigint.watch().first;
    await server.stop();
  } catch (e) {
    print('Error starting server: $e');
    exit(1);
  }
}

Future<void> updateCurrentDatabase() async {
  await Icd10cm.instance.getItemFromFile("assets/${Variables.instance.icd10cmFile}", Variables.instance.icd10cmTable);
  await Icd10cm.instance.getItemFromFile("assets/${Variables.instance.icd10pcsFile}", Variables.instance.icd10pcsTable);
  await Icd10cm.instance.getItemFromFile("assets/${Variables.instance.dhsFile}", Variables.instance.dhsTable);
  await Loinc.instance.getItemFromFile("assets/${Variables.instance.lonicFile}", Variables.instance.lonicTable);
  await FdaDrug.instance.getItemFromFile("assets/${Variables.instance.fdaDrugFile}", Variables.instance.fdaDrugTable);

  print('Database updated successfully.');
}
