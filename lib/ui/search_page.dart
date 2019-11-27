import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:typed_data';
import 'dart:io';
import 'dart:async';

class SearchPage extends StatefulWidget {
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController _textEditingController = TextEditingController();
  String query = '';
  Database database;
  var result = List();

  @override
  void initState() {
    loadDatabase();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search in Quran'),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(top: 20.0),
              padding: EdgeInsetsDirectional.only(start: 5.0, end: 10.0),
              height: 40.0,
              width: 300.0,
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(30.0))),
              child: Directionality(
                  textDirection: TextDirection.rtl,
                  child: TextField(
                    controller: _textEditingController,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Search the verses of the Quran',
                        hintStyle: TextStyle(color: Colors.grey),
                        suffixIcon: IconButton(
                            icon: Icon(Icons.search),
                            onPressed: () => _searchInQuranFor(query))),
                    onChanged: (val) {
                      query = val;
                    },
                  )),
            ),
            Expanded(
                child: Container(
                    width: double.infinity,
                    height: 400.0,
                    margin: EdgeInsetsDirectional.only(
                        top: 20.0, start: 20.0, end: 20.0),
                    child: ListView.builder(
                        itemCount: 3,
                        itemBuilder: (BuildContext context, int position) =>
                            _buildSearchResultListItem(context, position))))

          ],
        ),
      ),
    );
  }

  Future<void> loadDatabase() async {
    String databasesPath = await getDatabasesPath();
    String dbPath = join(databasesPath, 'assets/database/quran_db.db');
    bool exists = await databaseExists(dbPath);
    print('DB Status: $exists');

    //await deleteDatabase(dbPath);
    // Create the writable database file from the bundled demo database file:
    ByteData data = await rootBundle.load('assets/database/quran_db.db');
    List<int> bytes =
        data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
    await File(dbPath).writeAsBytes(bytes);
    database = await openDatabase(dbPath);
  }

  Future<List> _searchInQuranFor(String query) async {
    result = await database
        .rawQuery("SELECT * FROM Quran WHERE AyaDiac LIKE '%$query%'");
    return result.toList();
  }

  Widget _buildSearchResultListItem(BuildContext context, int position) {
    return Container(
      color: Colors.black12,
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                child: Text('بسم الله الرحمن الرحيم'),
              ),
              Container(
                child: Icon(Icons.ac_unit),
              )
            ],
          ),
          Row(
            children: <Widget>[
              Container(
                width: 80.0,
                height: 30.0,
                color: Colors.lightGreenAccent,
                child: Text('صفحة: 1'),
              ),
              Container(
                width: 80.0,
                height: 30.0,
                color: Colors.lightGreenAccent,
                child: Text('جزء: 1'),
              ),
              Container(
                width: 80.0,
                height: 30.0,
                color: Colors.lightGreenAccent,
                child: Text('سورة: الفاتحة'),
              )
            ],
          )
        ],
      ),
    );
  }
}
