import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quran_app/resources/colors.dart';

class HomePage extends StatefulWidget {
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController _textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: PreferredSize(
      preferredSize: Size.fromHeight(130.0),
      child: AppBar(
        elevation: 0.0,
        titleSpacing: 0.0,
        flexibleSpace: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(left: 10.0),
                  margin: EdgeInsets.only(top: 30.0, left: 5.0),
                  height: 40.0,
                  width: 280.0,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(30.0))),
                  child: TextField(
                    controller: _textEditingController,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Search the verses of the Quran',
                        hintStyle: TextStyle(color: Colors.grey),
                        suffixIcon: Icon(Icons.search)),
                  ),
                ),
                InkWell(
                  splashColor: AppColors.primaryColor,
                  child: Container(
                    width: 24.0,
                    height: 24.0,
                    margin: EdgeInsets.only(top: 30.0, left: 5.0),
                    child: Icon(
                      Icons.notifications_active,
                      color: Colors.white,
                    ),
                  ),
                  onTap: () {
                    print('Notification pressed');
                  },
                ),
                InkWell(
                  splashColor: AppColors.primaryColor,
                  child: Container(
                    width: 24.0,
                    height: 24.0,
                    margin: EdgeInsets.only(top: 30.0, left: 15.0),
                    child: Icon(
                      Icons.language,
                      color: Colors.white,
                    ),
                  ),
                  onTap: () {
                    print('Language pressed');
                  },
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                InkWell(
                  splashColor: AppColors.primaryColor,
                  child: Container(
                    width: 80.0,
                    height: 80.0,
                    margin: EdgeInsets.only(left: 15.0),
                    child: Column(
                      children: <Widget>[
                        IconButton(
                            icon: Icon(Icons.content_paste, color: Colors.white,), onPressed: () {}),
                        Text(
                          'islamic',
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                  onTap: () {
                    print('islamic pressed');
                  },
                ),
                InkWell(
                  splashColor: AppColors.primaryColor,
                  child: Container(
                    width: 80.0,
                    height: 80.0,
                    margin: EdgeInsets.only(left: 15.0),
                    child: Column(
                      children: <Widget>[
                        IconButton(
                            icon: Icon(Icons.note, color: Colors.white,), onPressed: () {}),
                        Text(
                          'notes',
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                  onTap: () {
                    print('notes pressed');
                  },
                ),
                InkWell(
                  splashColor: AppColors.primaryColor,
                  child: Container(
                    width: 80.0,
                    height: 80.0,
                    margin: EdgeInsets.only(left: 15.0),
                    child: Column(
                      children: <Widget>[
                        IconButton(
                            icon: Icon(Icons.info, color: Colors.white,), onPressed: () {}),
                        Text(
                          'info',
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                  onTap: () {
                    print('info pressed');
                  },
                ),
              ],
            )
          ],
        ),
      ),
    ));
  }
}
