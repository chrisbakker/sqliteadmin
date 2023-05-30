import 'dart:io';
import 'package:sqlite3/sqlite3.dart';
import 'package:dart_console/dart_console.dart';
import 'commands/table.dart';
import 'commands/query.dart';
import 'commands/command.dart';

late Database _db;

void main(List<String> arguments) {
  if (arguments.isEmpty) {
    print("Database file name required.");
    exit(1);
  }

  final dbName = arguments.first;
  print(
      'Connected to $dbName. Type \'quit\' to exit or \'help\' for further information.');
  _db = sqlite3.open(dbName);

  while (true) {
    final input = stdin.readLineSync();

    if (input == "quit") {
      print('Quitting...');
      _db.dispose();
      exit(1);
    }

    List<String> slices = input!.split(" ");
    if (slices.isEmpty) {
      exit;
    } else {
      if (slices[0] == "help") {
        printHelp();
      } else if (slices[0] == "tables") {
        handleTables(_db, slices);
      } else if (slices[0] == "query") {
        handleQuery(_db, input, slices);
      } else if (slices[0] == "command") {
        handleCommand(_db, input, slices);
      } else {
        print('Invalid command. Type \'help\' for more information.');
      }
    }
  }
}

void printHelp() {
  List<List<Object>> tableData = [
    ['tables'],
    ['query'],
    ['command'],
    ['quit']
  ];
  final table = Table()
    ..insertColumn(header: 'Commands', alignment: TextAlignment.left)
    ..insertRows(tableData)
    ..borderStyle = BorderStyle.square
    ..borderColor = ConsoleColor.brightBlue
    ..borderType = BorderType.vertical
    ..headerStyle = FontStyle.bold;
  print(table);
  print('For further help type in command space help.');
}
