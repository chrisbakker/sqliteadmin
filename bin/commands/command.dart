import 'package:sqlite3/sqlite3.dart';
import 'package:dart_console/dart_console.dart';

void handleCommand(
  Database db,
  String input,
  List<String> slices,
) {
  if (slices[1] == "help") {
    printHelp();
    return;
  }
  input = input.trim();
  String query = input.substring(8);
  try {
    db.execute(query);
    print("Command executed");
  } catch (err) {
    print('Syntax error');
  }
}

void printHelp() {
  List<List<Object>> tableData = [
    ['command \'SQL Statement\'', 'Execute a SQL statement']
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
