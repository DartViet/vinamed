import 'package:flutter/material.dart';
import 'package:ltdmed/appbar/appbar.dart';
import 'package:ltdmed/widgets/code_search/code_search.dart';

class HealthRecord extends StatefulWidget {
  const HealthRecord({super.key});

  @override
  State<HealthRecord> createState() => _HealthRecordState();
}

class _HealthRecordState extends State<HealthRecord> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: FAppbar(),
      body: Padding(padding: const EdgeInsets.all(16.0), child: CodeSearch()),
      floatingActionButton: FloatingActionButton(onPressed: () {}, child: Icon(Icons.add)),
    );
  }
}
