import 'package:flutter/material.dart';
import 'dart:math';

class FuelingTableList extends StatefulWidget {
  const FuelingTableList({Key? key}) : super(key: key);

  @override
  State<FuelingTableList> createState() => _FuelingTableListState();
}

class _FuelingTableListState extends State<FuelingTableList> {
  final DataTableSource _data = MyData();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 10,
        ),
        PaginatedDataTable(
          source: _data,
          columns: const [
            DataColumn(label: Text('Start Date')),
            DataColumn(label: Text('Start(KM)')),
            DataColumn(label: Text('End(KM)'))
          ],
          columnSpacing: 80,
          horizontalMargin: 10,
          rowsPerPage: 8,
          showCheckboxColumn: false,
        ),
      ],
    );
  }
}

class MyData extends DataTableSource {
  // Generate some made-up data
  final List<Map<String, dynamic>> _data = List.generate(
      200,
      (index) => {
            "date": "$index-2-2020",
            "start": Random().nextInt(10000),
            "end": Random().nextInt(10000)
          });

  @override
  bool get isRowCountApproximate => false;
  @override
  int get rowCount => _data.length;
  @override
  int get selectedRowCount => 0;
  @override
  DataRow getRow(int index) {
    return DataRow(cells: [
      DataCell(Text(_data[index]['date'].toString())),
      DataCell(Text(_data[index]['start'].toString())),
      DataCell(Text(_data[index]["end"].toString())),
    ]);
  }
}
