import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:quran_app/PODO/quran.dart';
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
  List<Quran> ayaList = List<Quran>();

  @override
  void initState() {
    loadDatabase();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
            onPressed: () => Navigator.pop(context)),
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
                    textInputAction: TextInputAction.search,
                    controller: _textEditingController,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Search the verses of the Quran',
                        hintStyle: TextStyle(color: Colors.grey),
                        suffixIcon: IconButton(
                            icon: Icon(Icons.search),
                            onPressed: () {
                              setState(() async {
                                await _searchInQuranFor(query);
                                convertResults();
                              });
                            })),
                    onChanged: (val) {
                      query = val;
                    },
                    onSubmitted: (query) {
                      setState(() async {
                        await _searchInQuranFor(query);
                        convertResults();
                      });
                    },
                  )),
            ),
            Expanded(
                child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    margin: EdgeInsetsDirectional.only(top: 10.0),
                    child: result.isEmpty
                        ? Container(
                            margin: EdgeInsetsDirectional.only(
                                top: 20.0, start: 20.0, end: 20.0),
                            child: Text(
                              'You can Search Any Word In Aya Quran',
                              textAlign: TextAlign.center,
                              style:
                                  TextStyle(fontSize: 25.0, color: Colors.grey),
                            ),
                          )
                        : ListView.builder(
                            itemCount: result.length,
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
    var output = await database
        .rawQuery("SELECT * FROM Quran WHERE AyaNoDiac LIKE '%$query%'");

    setState(() {
      result = output;
    });
    return result.toList();
  }

  void convertResults() async {
    ayaList.clear();
    ayaList = result.map((json) => Quran.fromJson(json)).toList();
  }

  Widget _buildSearchResultListItem(BuildContext context, int position) {
    return Container(
      padding: EdgeInsetsDirectional.only(start: 20.0, end: 20.0, bottom: 5.0),
      color: position & 1 == 0 ? Colors.black12 : Colors.white,
      width: MediaQuery.of(context).size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            margin:
                EdgeInsetsDirectional.only(top: 20.0, end: 5.0, bottom: 5.0),
            child: Text(
              ayaList[position].ayaBody,
              maxLines: 4,
              textAlign: TextAlign.right,
              style: TextStyle(fontSize: 16.0),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                width: 105.0,
                height: 30.0,
                color: Colors.green[300],
                child: Align(
                  alignment: AlignmentDirectional.center,
                  child: Text('Sorat: ${ayaList[position].soraNameAr}',
                      style: TextStyle(fontSize: 16.0)),
                ),
              ),
              Container(
                  width: 105.0,
                  height: 30.0,
                  color: Colors.yellow[300],
                  child: Align(
                    alignment: AlignmentDirectional.center,
                    child: Text('Part: ${ayaList[position].partNum}',
                        style: TextStyle(fontSize: 16.0)),
                  )),
              Container(
                  width: 105.0,
                  height: 30.0,
                  color: Colors.purple[200],
                  child: Align(
                    alignment: AlignmentDirectional.center,
                    child: Text(
                      'Page: ${ayaList[position].pageNum}',
                      style: TextStyle(fontSize: 16.0),
                    ),
                  )),
            ],
          )
        ],
      ),
    );
  }
}
