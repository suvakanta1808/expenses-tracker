import 'dart:io';
import 'package:expenses_tracker/models/expense.dart';
import 'package:flutter/cupertino.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';

class DBHelper {
  static Database? _db;

  Future<Database> get dataBase async => _db ??= await initDb();

  initDb() async {
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, 'expenses.db');
    return openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
      await db.execute(
          'CREATE TABLE Expenses(title TEXT(20),desc TEXT(20),amount DOUBLE,date TEXT,id TEXT PRIMARY KEY)');
    });
  }

  Future<void> insertIntoExpensesTable(Expense exp) async {
    final db = await dataBase;
    await db.insert('Expenses', {
      'title': exp.title,
      'desc': exp.description,
      'amount': exp.amount,
      'date': exp.date.toString(),
      'id': DateTime.now().toString(),
    });
    await getDataFromtable();
  }

  Future<void> deleteEntryFromtable(String id) async {
    final db = await dataBase;
    await db.delete('Expenses', where: 'id = ?', whereArgs: [id]);
  }

  Future<List<Expense>> getDataFromtable() async {
    final db = await DBHelper().dataBase;
    var list = await db.query('Expenses');
    List<Expense> dataList = [];
    list.forEach((exp) {
      dataList.add(Expense(
          id: exp['id'].toString(),
          title: exp['title'].toString(),
          description: exp['desc'].toString(),
          date: DateTime.parse(exp['date'].toString()),
          amount: double.parse(exp['amount'].toString())));
    });
    return dataList;
  }
}
