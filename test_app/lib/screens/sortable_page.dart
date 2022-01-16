import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:test_app/model/note.dart';
import 'package:test_app/widget/scrollable_widget.dart';

class SortablePage extends StatefulWidget {
  final List<Note> currencies;
  SortablePage({required this.currencies});
  @override
  _SortablePageState createState() => _SortablePageState();
}

class _SortablePageState extends State<SortablePage> {
  int? sortColumnIndex;
  bool isAscending = false;

  @override
  Widget build(BuildContext context) => Scaffold(
        body: ScrollableWidget(child: buildDataTable()),
      );

  Widget buildDataTable() {
    final columns = ['Symbol', 'Name', 'Price'];

    return DataTable(
      sortAscending: isAscending,
      sortColumnIndex: sortColumnIndex,
      columns: getColumns(columns),
      rows: getRows(widget.currencies),
    );
  }

  List<DataColumn> getColumns(List<String> columns) => columns
      .map((String column) => DataColumn(
            label: Text(column),
            onSort: onSort,
          ))
      .toList();

  List<DataRow> getRows(List<Note> currencies) => currencies.map((Note curr) {
        final cells = [curr.symbol, curr.name, curr.price];

        return DataRow(cells: getCells(cells));
      }).toList();

  List<DataCell> getCells(List<dynamic> cells) =>
      cells.map((data) => DataCell(Text('$data'))).toList();

  void onSort(int columnIndex, bool ascending) {
    if (columnIndex == 0) {
      widget.currencies.sort((curr1, curr2) =>
          compareString(ascending, curr1.symbol, curr2.symbol));
    } else if (columnIndex == 1) {
      widget.currencies.sort(
          (curr1, curr2) => compareString(ascending, curr1.name, curr2.name));
    } else if (columnIndex == 2) {
      widget.currencies.sort(
          (curr1, curr2) => sortPrice(ascending, curr1.price, curr2.price));
    }

    setState(() {
      this.sortColumnIndex = columnIndex;
      this.isAscending = ascending;
    });
  }

  int compareString(bool ascending, String value1, String value2) =>
      ascending ? value1.compareTo(value2) : value2.compareTo(value1);

  int sortPrice(bool ascending, double value1, double value2) => ascending
      ? double.parse(value1.toString())
          .compareTo(double.parse(value2.toString()))
      : double.parse(value2.toString())
          .compareTo(double.parse(value1.toString()));
}
