import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quran_app/resources/colors.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:quran_app/resources/strings.dart';
import 'package:quran_app/ui/sora_page.dart';
import 'package:seekbar/seekbar.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:quran_app/ui/readers_dialog.dart';

class HomePage extends StatefulWidget {
  Function navigateToPage;

  HomePage({this.navigateToPage});

  _HomePageState createState() => _HomePageState();
}

bool isExpanded = false;
bool isPlayerRequested = false;
int _currentPage = 0;

AudioPlayer _audioPlayer = AudioPlayer();
double _value = 0.0;
Duration duration;
Duration position;
double _percent = 0.0;
String selectedAPI = ReadersAPI.readerURL[0];

// ignore: unused_element
StreamSubscription _positionSubscription;
// ignore: unused_element
StreamSubscription _audioPlayerStateSubscription;

PlayerState playerState = PlayerState.stopped;

get isPlaying => playerState == PlayerState.playing;

get isPaused => playerState == PlayerState.paused;

enum PlayerState { stopped, playing, paused }

CarouselSlider carouselSlider;

class _HomePageState extends State<HomePage> {
  TextEditingController _textEditingController = TextEditingController();
  var result;

  @override
  void initState() {
    initAudioPlayer();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
                        InkWell(
                          child: Container(
                            padding: EdgeInsets.only(left: 10.0),
                            margin: EdgeInsets.only(top: 30.0, left: 5.0),
                            height: 40.0,
                            width: 280.0,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(30.0))),
                            child: Container(
                              padding: EdgeInsetsDirectional.only(
                                  start: 10.0, end: 15.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(
                                    'Search the verses of Quran',
                                    style: TextStyle(
                                        color: Colors.grey, fontSize: 16.0),
                                  ),
                                  Icon(
                                    Icons.search,
                                    color: Colors.grey,
                                  )
                                ],
                              ),
                            ),
                          ),
                          onTap: () => Navigator.pushNamed(context, '/search'),
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
                              color: isExpanded
                                  ? Colors.transparent
                                  : Colors.greenAccent,
                              size: 30.0,
                            ),
                            onPressed: () {
                              setState(() {
                                if (isPlaying) {
                                  pause();
                                  isPlayerRequested = false;
                                } else {
                                  play();
                                  isPlayerRequested = true;
                                }
                                //isPlaying = !isPlaying;
                              });
                            }),
                        Container(
                          width: 240.0,
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
                        ),
                        IconButton(
                            icon: Icon(
                              Icons.person,
                              color: isExpanded
                                  ? Colors.transparent
                                  : AppColors.white,
                            ),
                            onPressed: () {
                              showDialog(
                                  barrierDismissible: true,
                                  context: context,
                                  builder: (BuildContext context) =>
                                      ReadersDialog(changeReader));
                            })
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
                            onPressed: () {
                              stop();
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => SoraPage(
                                            navigateToPage: navigateToPage,
                                          )));
                            },
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
              if (_value == 1.0) {
                print('PLAYER COMPLETED!');
                setState(() {
                  carouselSlider.previousPage(
                      duration: Duration(milliseconds: 500),
                      curve: Curves.linear);
                });
              }
            }));
    _audioPlayerStateSubscription =
        _audioPlayer.onPlayerStateChanged.listen((s) {
      if (s == AudioPlayerState.PLAYING) {
        setState(() {
          _audioPlayer
              .getDuration()
              .then((val) => duration = Duration(seconds: val));
        });
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
    if (_currentPage == 0) {
      pageNumber = '00${_currentPage + 1}';
    } else if (_currentPage > 0 && _currentPage < 506) {
      pageNumber = '${604 - _currentPage + 1}';
    } else if (_currentPage > 505 && _currentPage < 596) {
      pageNumber = '0${604 - _currentPage + 1}';
    } else {
      pageNumber = '00${604 - _currentPage + 1}';
    }
    print('REQUESTING PAGE: $pageNumber');
    await _audioPlayer.play("http://everyayah.com/data/Abdul_Basit_Murattal_64kbps/PageMp3s/Page001.mp3", position: Duration(minutes: 0, seconds: 0));
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
    int _exactTime = (portion * duration.inSeconds).round();
    await _audioPlayer.seek(Duration(seconds: _exactTime));
  }

  Future<String> get _localPath async {
    final directory = await getTemporaryDirectory();

    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/file.txt');
  }

  Future<void> _downloadAudioFile(String url) async {
    final client = new http.Client();
    http.StreamedResponse response =
        await client.send(http.Request("GET", Uri.parse(url)));
    var length = response.contentLength;
    var received = 0;
    final downloadFile = await _localFile;
    var sink = downloadFile.openWrite();

    await response.stream.map((s) {
      received += s.length;
      _percent = (received / length);
      print("${(received / length) * 100} %");
      return s;
    }).pipe(sink);
  }

  Future<void> changeReader(int position) async {
    await stop();
    selectedAPI = ReadersAPI.readerURL[position];
    await play();
  }

  void navigateToPage(int position) {
    if (position == 0) {
      _currentPage = position + 1;
    } else if (position > 0 && position < 506) {
      _currentPage = 604 - position + 1;
    } else if (position > 505 && position < 596) {
      _currentPage = 604 - position + 1;
    } else {
      _currentPage = 604 - position + 1;
    }
  }
}

class CarouselWidget extends StatefulWidget {
  _CarouselState createState() => _CarouselState();
}

class _CarouselState extends State<CarouselWidget> {
  List pagesList = List<String>(604);

  @override
  Widget build(BuildContext context) {
    carouselSlider = CarouselSlider(
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
            _percent = 0.0;
            if (isPlayerRequested) {
              play();
            }
          });
        },
        items: pagesList.map((color) {
          return Builder(builder: (BuildContext context) {
            return _buildPagesList(context, _currentPage, 400.0);
          });
        }).toList());

    return Container(
      width: MediaQuery.of(context).size.width,
      child: carouselSlider,
    );
  }

  Widget _buildPagesList(BuildContext context, int position, double width) {
    return Container(
      margin: EdgeInsets.only(top: isExpanded ? 20.0 : 0.0),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/filtered/$position.jpg'),
              fit: isExpanded ? BoxFit.fill : BoxFit.cover)),
    );
  }

  Future<void> play() async {
    String pageNumber;
    if (_currentPage == 0) {
      pageNumber = '00${_currentPage + 1}';
    } else if (_currentPage > 0 && _currentPage < 506) {
      pageNumber = '${604 - _currentPage + 1}';
    } else if (_currentPage > 505 && _currentPage < 596) {
      pageNumber = '0${604 - _currentPage + 1}';
    } else {
      pageNumber = '00${604 - _currentPage + 1}';
    }
    await _audioPlayer.play(selectedAPI + 'Page$pageNumber.mp3');
    setState(() => playerState = PlayerState.playing);
  }
}
