import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quran_app/resources/colors.dart';
import 'package:carousel_slider/carousel_slider.dart';

class HomePage extends StatefulWidget {
  _HomePageState createState() => _HomePageState();
}

bool isExpanded = false;

class _HomePageState extends State<HomePage> {
  TextEditingController _textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: isExpanded
          ? null
          : PreferredSize(
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
                              borderRadius:
                                  BorderRadius.all(Radius.circular(30.0))),
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
                                    icon: Icon(
                                      Icons.content_paste,
                                      color: Colors.white,
                                    ),
                                    onPressed: () {}),
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
                                    icon: Icon(
                                      Icons.note,
                                      color: Colors.white,
                                    ),
                                    onPressed: () {}),
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
                                    icon: Icon(
                                      Icons.info,
                                      color: Colors.white,
                                    ),
                                    onPressed: () {}),
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
            ),
      body: Stack(
        children: <Widget>[
          InkWell(
            onTap: () {
              setState(() {
                isExpanded = !isExpanded;
                print('Home Expansion State: $isExpanded');
              });
            },
            child: CarouselWidget(),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                      color: isExpanded
                          ? Colors.transparent
                          : AppColors.primaryColor,
                      borderRadius: BorderRadius.all(Radius.circular(5.0))),
                  child: FlatButton(
                      onPressed: () {},
                      child: Text(
                        'Quran',
                        style: TextStyle(
                            color:
                                isExpanded ? Colors.transparent : Colors.white,
                            fontSize: 12.0),
                      )),
                  width: 100.0,
                  height: 40.0,
                  margin: EdgeInsets.only(bottom: 10.0),
                ),
                Container(
                  decoration: BoxDecoration(
                      color: isExpanded
                          ? Colors.transparent
                          : AppColors.primaryColor,
                      borderRadius: BorderRadius.all(Radius.circular(5.0))),
                  child: FlatButton(
                      onPressed: () {},
                      child: Text(
                        'Translate',
                        style: TextStyle(
                            color:
                                isExpanded ? Colors.transparent : Colors.white,
                            fontSize: 12.0),
                      )),
                  width: 100.0,
                  height: 40.0,
                  margin: EdgeInsets.only(bottom: 10.0),
                ),
                Container(
                  decoration: BoxDecoration(
                      color: isExpanded
                          ? Colors.transparent
                          : AppColors.primaryColor,
                      borderRadius: BorderRadius.all(Radius.circular(5.0))),
                  child: FlatButton(
                      onPressed: () {},
                      child: Text(
                        'Bookmarks',
                        style: TextStyle(
                            color:
                                isExpanded ? Colors.transparent : Colors.white,
                            fontSize: 12.0),
                      )),
                  width: 100.0,
                  height: 40.0,
                  margin: EdgeInsets.only(bottom: 10.0),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

class CarouselWidget extends StatefulWidget {
  _CarouselState createState() => _CarouselState();
}

class _CarouselState extends State<CarouselWidget> {
  int _currentPage = 0;
  List pagesList = List<String>(604);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: CarouselSlider(
          scrollPhysics: BouncingScrollPhysics(),
          height: MediaQuery.of(context).size.height,
          initialPage: 0,
          viewportFraction: 0.99,
          reverse: false,
          enlargeCenterPage: true,
          onPageChanged: (index) {
            setState(() {
              _currentPage = index;
            });
          },
          items: pagesList.map((color) {
            return Builder(builder: (BuildContext context) {
              return _buildPagesList(context, _currentPage, 400.0);
            });
          }).toList()),
    );
  }

  Widget _buildPagesList(BuildContext context, int position, double width) {
    print('Expansion State: $isExpanded');
    return Container(
      margin: EdgeInsets.only(top: isExpanded ? 20.0 : 0.0),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/filtered/$position.jpg'),
              fit: isExpanded ? BoxFit.fill : BoxFit.cover)),
    );
  }
}
