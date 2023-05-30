import 'package:sqlite3/sqlite3.dart';
import 'package:dart_console/dart_console.dart';

void handleQuery(
  Database db,
  String input,
  List<String> slices,
) {
  if (slices[1] == "help") {
    printHelp();
    return;
  }
  input = input.trim();
  String query = input.substring(6);
  try {
    final ResultSet resultSet = db.select(query);
    List<String> columnNames = resultSet.columnNames;
    List<List<Object>> tableData = [];
    for (var row in resultSet) {
      List<Object> rowData = [];
      for (var i = 0; i < columnNames.length; i++) {
        rowData.add(row.columnAt(i));
      }
      tableData.add(rowData);
    }

    var table = Table()
      ..borderStyle = BorderStyle.square
      ..borderColor = ConsoleColor.brightBlue
      ..borderType = BorderType.vertical
      ..headerStyle = FontStyle.bold;

    for (String columnName in columnNames) {
      table.insertColumn(header: columnName, alignment: TextAlignment.left);
    }
    table.insertRows(tableData);
    print(table);
  } catch (err) {
    print('Syntax error');
  }
}

void printHelp() {
  List<List<Object>> tableData = [
    ['query \'SQL Statement\'', 'Execute a SQL statement returning data.']
  ];
  final table = Table()
    ..insertColumn(header: 'Command', alignment: TextAlignment.left)
    ..insertColumn(header: 'Description', alignment: TextAlignment.left)
    ..insertRows(tableData)
    ..borderStyle = BorderStyle.square
    ..borderColor = ConsoleColor.brightBlue
    ..borderType = BorderType.vertical
    ..headerStyle = FontStyle.bold;
  print(table);
}
