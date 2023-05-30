import 'package:sqlite3/sqlite3.dart';
import 'package:dart_console/dart_console.dart';

void handleTables(Database db, List<String> slices) {
  if (slices.length < 2) {
    print('This command requires one parameter.');
    return;
  }
  if (slices[1] == "help") {
    printHelp();
  } else if (slices[1] == "list") {
    List<String> tableNames = [];
    try {
      var results =
          db.select("SELECT name FROM sqlite_master WHERE type='table'");
      for (var row in results) {
        var name = row.columnAt(0);
        tableNames.add(name);
      }

      List<List<Object>> resultList = tableNames.map((name) {
        List<Object> row = [name];
        return row;
      }).toList();

      final table = Table()
        ..insertColumn(header: 'Name', alignment: TextAlignment.left)
        ..insertRows(resultList)
        ..borderStyle = BorderStyle.square
        ..borderColor = ConsoleColor.brightBlue
        ..borderType = BorderType.vertical
        ..headerStyle = FontStyle.bold;
      print(table);
    } catch (err) {
      print('Syntax error');
    }
  } else if (slices[1] == "desc") {
    final tableName = slices[2];
    try {
      var results = db.select('PRAGMA table_info($tableName);');
      List<List<Object>> tableData = [];
      for (var row in results) {
        List<Object> rowData = [
          row.columnAt(0),
          row.columnAt(1),
          row.columnAt(2),
          row.columnAt(3),
          row.columnAt(5)
        ];
        tableData.add(rowData);
      }
      final table = Table()
        ..insertColumn(header: 'cid', alignment: TextAlignment.left)
        ..insertColumn(header: 'name')
        ..insertColumn(header: 'type')
        ..insertColumn(header: 'notnull')
        ..insertColumn(header: 'pk')
        ..insertRows(tableData)
        ..borderStyle = BorderStyle.square
        ..borderColor = ConsoleColor.brightBlue
        ..borderType = BorderType.vertical
        ..headerStyle = FontStyle.bold;
      print(table);
    } catch (err) {
      print('Syntax error');
    }
  }
}

void printHelp() {
  List<List<Object>> tableData = [
    ['tables list', 'Lists all the tables in the database.']
  ];
  final table = Table()
    ..insertColumn(header: 'Table Command', alignment: TextAlignment.left)
    ..insertColumn(header: 'Description', alignment: TextAlignment.left)
    ..insertRows(tableData)
    ..borderStyle = BorderStyle.square
    ..borderColor = ConsoleColor.brightBlue
    ..borderType = BorderType.vertical
    ..headerStyle = FontStyle.bold;
  print(table);
}
