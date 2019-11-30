import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:quran_app/PODO/sora.dart';
import 'package:quran_app/ui/home_page.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:typed_data';
import 'dart:io';
import 'dart:async';

class SoraPage extends StatefulWidget {
  Function navigateToPage;

  SoraPage({Function navigateToPage}) {
    this.navigateToPage = navigateToPage;
  }

  _SoraPageState createState() => _SoraPageState();
}

class _SoraPageState extends State<SoraPage> {
  List<Sora> _quranList = List<Sora>();
  String query = '';
  Database database;
  var result = List();

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() async {
    if (database != null && database.isOpen) {
      print('DB was OPENED!');
      await database.close();
      await loadDatabase();
      await _fetchSoraData();
      convertResults();
    } else {
      print('DB was CLOSED!');

      await loadDatabase();
      await _fetchSoraData();
      convertResults();
    }

    super.didChangeDependencies();
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
        title: Text('Quran'),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
              child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child: ListView.builder(
                      itemCount: _quranList.length,
                      itemBuilder: (BuildContext context, int position) =>
                          _buildSoraListItem(context, position)))),
        ],
      ),
    );
  }

  Widget _buildSoraListItem(BuildContext context, int position) {
    return InkWell(
      child: Container(
        padding: EdgeInsets.only(top: 5.0, bottom: 5.0),
        color: position & 1 == 0 ? Colors.black12 : Colors.white,
        width: MediaQuery.of(context).size.width,
        height: 80.0,
        child: Row(
          children: <Widget>[
            Stack(
              alignment: AlignmentDirectional.center,
              children: <Widget>[
                Container(
                  margin: EdgeInsetsDirectional.only(end: 10.0),
                  child: Image.asset('assets/icons/ayah_bg.png'),
                ),
                Container(
                    margin: EdgeInsetsDirectional.only(end: 8.0),
                    child: Center(
                      child: Text(
                        '${_quranList[position].id}',
                        style: TextStyle(fontSize: 15.0),
                      ),
                    ))
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  child: Text(
                    _quranList[position].nameEn,
                    style: TextStyle(fontSize: 20.0),
                  ),
                ),
                Container(
                  child: Text(
                      'Number of verses: ${_quranList[position].ayatCount}'),
                )
              ],
            )
          ],
        ),
      ),
      onTap: () {
        widget.navigateToPage(_quranList[position].pageNum);
        Navigator.pop(context);
      },
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

  Future<List> _fetchSoraData() async {
    var output = await database.rawQuery("SELECT * FROM Sora");

    setState(() {
      result = output;
    });
    return result.toList();
  }

  void convertResults() {
    _quranList = result.map((json) => Sora.fromJson(json)).toList();
  }

  @override
  void dispose() {
    super.dispose();
  }
}
