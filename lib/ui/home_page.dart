import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quran_app/resources/colors.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:audioplayer/audioplayer.dart';
import 'package:quran_app/resources/strings.dart';
import 'package:seekbar/seekbar.dart';
import 'dart:async';

class HomePage extends StatefulWidget {
  _HomePageState createState() => _HomePageState();
}

bool isExpanded = false;
int _currentPage = 0;

AudioPlayer _audioPlayer = AudioPlayer();
double _value = 0.0;
Duration duration;
Duration position;
// ignore: unused_element
StreamSubscription _positionSubscription;
// ignore: unused_element
StreamSubscription _audioPlayerStateSubscription;

PlayerState playerState = PlayerState.stopped;

get isPlaying => playerState == PlayerState.playing;

get isPaused => playerState == PlayerState.paused;

enum PlayerState { stopped, playing, paused }

class _HomePageState extends State<HomePage> {
  TextEditingController _textEditingController = TextEditingController();


  @override
  void initState() {
    initAudioPlayer();
    super.initState();
  }

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
              });
            },
            child: CarouselWidget(),
          ),
          Align(
              alignment: Alignment.bottomCenter,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Container(
                    margin:
                        EdgeInsets.only(bottom: 10.0, left: 10.0, right: 10.0),
                    height: 50.0,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        color: isExpanded
                            ? Colors.transparent
                            : AppColors.primaryColor,
                        borderRadius: BorderRadius.all(Radius.circular(30.0))),
                    child: Row(
                      children: <Widget>[
                        IconButton(
                            icon: Icon(
                              isPlaying
                                  ? Icons.pause_circle_outline
                                  : Icons.play_circle_outline,
                              color: Colors.greenAccent,
                              size: 30.0,
                            ),
                            onPressed: () {
                              setState(() {
                                if (isPlaying) {
                                  pause();
                                } else {
                                  play();
                                }
                                //isPlaying = !isPlaying;
                              });
                            }),
                        Container(
                          width: 250.0,
                          height: 5.0,
                          child: SeekBar(
                            value: _value,
                            secondValue: 0.01,
                            onStartTrackingTouch: () => print('STARTED'),
                            onStopTrackingTouch: () {},
                            onProgressChanged: (value) {
                              print('PROGRESS = $value');
                              _value = value;
                              seekTo(value);
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Container(
                        decoration: BoxDecoration(
                            color: isExpanded
                                ? Colors.transparent
                                : AppColors.primaryColor,
                            borderRadius:
                                BorderRadius.all(Radius.circular(5.0))),
                        child: FlatButton(
                            onPressed: () {},
                            child: Text(
                              'Quran',
                              style: TextStyle(
                                  color: isExpanded
                                      ? Colors.transparent
                                      : Colors.white,
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
                            borderRadius:
                                BorderRadius.all(Radius.circular(5.0))),
                        child: FlatButton(
                            onPressed: () {},
                            child: Text(
                              'Translate',
                              style: TextStyle(
                                  color: isExpanded
                                      ? Colors.transparent
                                      : Colors.white,
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
                            borderRadius:
                                BorderRadius.all(Radius.circular(5.0))),
                        child: FlatButton(
                            onPressed: () {},
                            child: Text(
                              'Bookmarks',
                              style: TextStyle(
                                  color: isExpanded
                                      ? Colors.transparent
                                      : Colors.white,
                                  fontSize: 12.0),
                            )),
                        width: 100.0,
                        height: 40.0,
                        margin: EdgeInsets.only(bottom: 10.0),
                      )
                    ],
                  ),
                ],
              ))
        ],
      ),
    );
  }

  void initAudioPlayer() {
    _audioPlayer = new AudioPlayer();
    _positionSubscription =
        _audioPlayer.onAudioPositionChanged.listen((p) => setState(() {
              position = p;
              _value = position.inSeconds / duration.inSeconds;
            }));
    _audioPlayerStateSubscription =
        _audioPlayer.onPlayerStateChanged.listen((s) {
      if (s == AudioPlayerState.PLAYING) {
        setState(() => duration = _audioPlayer.duration);
      } else if (s == AudioPlayerState.STOPPED) {
        onComplete();
        setState(() {
          position = duration;
          _value = 0.0;
        });
      }
    }, onError: (msg) {
      setState(() {
        playerState = PlayerState.stopped;
        duration = new Duration(seconds: 0);
        position = new Duration(seconds: 0);
      });
    });
  }

  void onComplete() {
    setState(() => playerState = PlayerState.stopped);
  }

  Future<void> play() async {
    String pageNumber;
    if(_currentPage == 0){
      pageNumber = '00${_currentPage + 1}';
    }else if (_currentPage > 0 && _currentPage < 9 ) {
      pageNumber = '${604- _currentPage + 1}';
    } else if (_currentPage > 9 && _currentPage < 99) {
      pageNumber = '0${604 - _currentPage + 1}';
    } else {
      pageNumber = '00${604 - _currentPage + 1}';
    }
    await _audioPlayer
        .play(AppStrings.QURAN_ABDULBASIT_API + 'Page$pageNumber.mp3');
    setState(() => playerState = PlayerState.playing);
  }

  Future<void> pause() async {
    await _audioPlayer.pause();
    setState(() => playerState = PlayerState.paused);
  }

  Future<void> stop() async {
    await _audioPlayer.stop();
    setState(() {
      playerState = PlayerState.stopped;
      position = new Duration();
    });
  }

  Future<void> seekTo(double portion) async {
    double _exactTime = portion * duration.inSeconds;
    await _audioPlayer.seek(_exactTime);
  }
}

class CarouselWidget extends StatefulWidget {
  _CarouselState createState() => _CarouselState();
}

class _CarouselState extends State<CarouselWidget> {
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
              _audioPlayer.stop();
              playerState = PlayerState.stopped;
              position = new Duration();

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
