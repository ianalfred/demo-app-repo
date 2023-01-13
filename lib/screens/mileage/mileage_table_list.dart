import 'package:driver/components/app_font.dart';
import 'package:flutter/material.dart';
import 'dart:math';

class MileageTableListScreen extends StatefulWidget {
  const MileageTableListScreen({Key? key}) : super(key: key);

  @override
  State<MileageTableListScreen> createState() => _MileageTableListScreenState();
}

class _MileageTableListScreenState extends State<MileageTableListScreen> {
  final DataTableSource _data = MyData();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 5.0,
        ),
        PaginatedDataTable(
          source: _data,
          columns: const [
            DataColumn(
                label: Text(
              'Start Date',
              style: TextStyle(
                color: Color(0xff202020),
                fontFamily: AppFont.font,
                fontSize: 13.0,
              ),
            )),
            DataColumn(
                label: Text(
              'Start(KM)',
              style: TextStyle(
                color: Color(0xff202020),
                fontFamily: AppFont.font,
                fontSize: 13.0,
              ),
            )),
            DataColumn(
                label: Text(
              'End(KM)',
              style: TextStyle(
                color: Colors.black,
                fontSize: 14.0,
                fontFamily: AppFont.font,
                fontWeight: FontWeight.w500,
              ),
            ))
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
      DataCell(Text(_data[index]['date'].toString(),
          style: const TextStyle(
            color: Color(0xff202020),
            fontSize: 13.0,
            fontFamily: AppFont.font,
            fontWeight: FontWeight.w500,
          ))),
      DataCell(Text(_data[index]['start'].toString(),
          style: const TextStyle(
            color: Color(0xff202020),
            fontSize: 13.0,
            fontFamily: AppFont.font,
            fontWeight: FontWeight.w500,
          ))),
      DataCell(Text(_data[index]["end"].toString(),
          style: const TextStyle(
            color: Color(0xff202020),
            fontSize: 13.0,
            fontFamily: AppFont.font,
            fontWeight: FontWeight.w500,
          ))),
    ]);
  }
}
