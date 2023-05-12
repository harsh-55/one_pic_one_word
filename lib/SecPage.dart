import 'dart:convert';
import 'dart:math';

import 'package:animated_button/animated_button.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:blur_container/blur_container.dart';
import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:just_audio/just_audio.dart';
import 'package:neon/neon.dart';
import 'package:one_pic_one_word/main.dart';

class SecPage extends StatefulWidget {
  const SecPage({Key? key}) : super(key: key);

  @override
  State<SecPage> createState() => _SecPageState();
}

class _SecPageState extends State<SecPage> with WidgetsBindingObserver {

  int coin = 500;

  FlutterTts flutterTts = FlutterTts();

  List someImages = [];

  List topList = [];
  List bottomList = [];
  List AnswerList = [];
  Color clr = Colors.orangeAccent.withOpacity(0.5);

  final controller = ConfettiController();

  AudioPlayer music = AudioPlayer();
  bool isPlaying = false; // Create a player

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _initImages();

    WidgetsBinding.instance.addObserver(this);
    // initmusic();
    // initplay();
  }

  initmusic() {
    music.setAsset("audio/hero-80s-127027.mp3");
    music.setLoopMode(LoopMode.all);
  }

  initplay() async {
    await music.play();
  }

  initpause() async {
    await music.pause();
  }

  initstop() async {
    await music.stop();
  }

  musicaction() {
    if (isPlaying) {
      //  initplay();
      isPlaying = false;
    } else {
      //  initpause();
      isPlaying = true;
    }
    setState(() {});
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // TODO: implement didChangeAppLifecycleState
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.resumed) {
      initplay();
    } else if (state == AppLifecycleState.paused) {
      initpause();
    }
  }

  String img = "";

  Future _initImages() async {
    clr = Colors.orangeAccent.withOpacity(0.5);
    // >> To get paths you need these 2 lines
    final manifestContent = await rootBundle.loadString('AssetManifest.json');

    final Map<String, dynamic> manifestMap = json.decode(manifestContent);
    // >> To get paths you need these 2 lines

    final imagePaths = manifestMap.keys
        .where((String key) => key.contains('Image/'))
        .where((String key) => key.contains('.webp'))
        .toList();

    setState(() {
      someImages = imagePaths;

      // int random = Random().nextInt(someImages.length);
      // randomimage = someImages[random];
      // String splitt = randomimage.split("/")[1];
      // String splittt = randomimage.split(".")[0];
      // AnswerList = splittt.split("");

      img = someImages[Random().nextInt(someImages.length)];
      AnswerList = img.split("/")[1].split(".")[0].split("");

      print("======$AnswerList");

      String abcd = "abcdefghijklmnopqrstuvwxyz";
      List abc = abcd.split("");
      abc.shuffle();

      bottomList = abc.getRange(0, 10 - AnswerList.length).toList();
      bottomList.addAll(AnswerList);
      bottomList.shuffle();
      topList = List.filled(AnswerList.length, "");

      print("=======$AnswerList=\n===${bottomList}");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        WillPopScope(
            onWillPop: () {
              return showExitPopup(context);
            },
            child: Scaffold(
                body: Stack(
              children: [
                Container(
                  height: double.infinity,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("images/backimage.jpg"),
                          fit: BoxFit.fill)),
                  child: BlurContainerWidget(
                    height: double.infinity,
                    width: double.infinity,
                  ),
                ),
                Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 10, top: 10, right: 10),
                      height: 60,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(10)),
                      child: Row(
                        children: [
                          IconButton(
                              onPressed: () {
                                showsetting();
                              },
                              icon: Icon(
                                Icons.settings_outlined,
                                color: Colors.white.withOpacity(0.9),
                                size: 30,
                              )),
                          SizedBox(width: 90),
                          Container(
                            height: 33,
                            width: 35,
                            child: Row(
                              children: [
                                Container(
                                  height: 30,
                                  width: 35,
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                    image: AssetImage('images/play_coin.png'),
                                  )),
                                ),
                                Center(
                                  child: Text(
                                    '',
                                    style: TextStyle(
                                        fontSize: 17,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                )
                              ],
                            ),
                          ),
                          Container(
                            height: 33,
                            width: 50,
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text("$coin",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.w600
                              ),
                              ),
                            ),
                          ),
                          SizedBox(width: 60),
                          IconButton(
                              onPressed: () {
                                _initImages();
                              },
                              icon: Icon(
                                Icons.skip_next,
                                size: 35,
                                color: Colors.white,
                              ))
                        ],
                      ),
                    ),
                    SizedBox(height: 30),
                    Container(
                      height: 250,
                      color: Colors.white.withOpacity(0.05),
                      child: Container(
                        margin: EdgeInsets.only(
                            top: 15, bottom: 15, left: 77, right: 77),
                        decoration: BoxDecoration(
                            color: Colors.transparent,
                            borderRadius: BorderRadius.circular(20),
                            image:
                                DecorationImage(image: new AssetImage("$img"))),
                      ),
                    ),
                    SizedBox(height: 30),
                    Container(
                      height: 65,
                      width: double.infinity,
                      alignment: Alignment.center,
                      child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        physics: BouncingScrollPhysics(),
                        itemCount: AnswerList.length,
                        itemBuilder: (context, index) {
                          return (topList[index].toString() == "")
                              ? Container(
                                  margin: EdgeInsets.all(3.5),
                                  height: 55,
                                  width: 45,
                                  decoration: BoxDecoration(
                                      color:
                                          Colors.orangeAccent.withOpacity(0.4),
                                      borderRadius: BorderRadius.circular(10)),
                                )
                              : InkWell(
                                  onTap: () {
                                    setState(() {
                                      if (topList[index] != "") {
                                        bottomList[map[index]] = topList[index];
                                        topList[index] = "";
                                        clr = Colors.orangeAccent
                                            .withOpacity(0.4);
                                      }
                                    });
                                  },
                                  child: Center(
                                    child: Container(
                                      margin: EdgeInsets.all(3),
                                      height: 50,
                                      width: 40,
                                      decoration: BoxDecoration(
                                          color: clr,
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: Center(
                                        child: Text(
                                            "${topList[index].toString().toUpperCase()}",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 25)),
                                      ),
                                    ),
                                  ),
                                );
                        },
                      ),
                    ),
                    SizedBox(height: 50),
                    Container(
                      margin: EdgeInsets.only(left: 20),
                      height: 150,
                      width: double.infinity,
                      child: GridView.builder(
                          physics: BouncingScrollPhysics(),
                          itemCount: bottomList.length,
                          itemBuilder: (context, index) {
                            return (bottomList[index].toString() == "")
                                ? AnimatedButton(
                                    color: Colors.orangeAccent.withOpacity(0.1),
                                    height: 60,
                                    width: 50,
                                    onPressed: () {},
                                    child: Text(""))
                                : AnimatedButton(
                                    color: Colors.orangeAccent.withOpacity(0.5),
                                    height: 60,
                                    width: 50,
                                    onPressed: () {
                                      setState(() {
                                        for (int i = 0;
                                            i < AnswerList.length;
                                            i++) {
                                          if (topList[i] == "") {
                                            topList[i] = bottomList[index];
                                            map[i] = index;
                                            bottomList[index] = "";
                                            if (topList.toString() ==
                                                AnswerList.toString()) {
                                              clr = Colors.green;
                                              win();
                                            } else if (i ==
                                                topList.length - 1) {
                                              if (topList.toString() !=
                                                  AnswerList.toString()) {
                                                clr = Colors.red;
                                              }
                                            }
                                            break;
                                          }
                                        }
                                      });
                                    },
                                    child: Text(
                                      "${bottomList[index].toString().toUpperCase()}",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 25),
                                    ));
                          },
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 5)),
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        AnimatedButton(
                          color: Colors.green.withOpacity(0.5),
                          height: 55,
                          width: 50,
                          onPressed: () {
                            hint();
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage("images/bulb.png"),
                                    opacity: 10,
                                    scale: 7)),
                          ),
                        ),
                        AnimatedButton(
                          color: Colors.red.withOpacity(0.5),
                          height: 55,
                          width: 50,
                          onPressed: () {
                            setState(() {

                            });
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage("images/cancel_kid.png"),
                                    opacity: 10,
                                    scale: 2)),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ],
            ))),
      ],
    );
  }

  void showsetting() {
    showDialog(
      context: context,
      builder: (context) {
        return Material(
          color: Colors.transparent,
          child: BlurContainerWidget(
            color: Colors.transparent,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 30, right: 30, top: 50),
                  child: Container(
                    height: 100,
                    width: double.infinity,
                    child: DefaultTextStyle(
                      style: TextStyle(fontSize: 50),
                      child: Neon(
                        text: 'SETTINGS',
                        color: Colors.red,
                        fontSize: 40,
                        font: NeonFont.Monoton,
                        flickeringText: true,
                        flickeringLetters: [0, 1, 2, 3, 4, 5, 6, 7, 8],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 130,
                ),
                Container(
                  height: 60,
                  width: 300,
                  decoration: BoxDecoration(
                    color: Colors.red.withOpacity(0.4),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    children: [
                      Container(
                          height: 50,
                          width: 225,
                          child: Center(
                            child: const DefaultTextStyle(
                                style: TextStyle(fontSize: 30),
                                child: Text("Sound")),
                          )),
                      SizedBox(
                        width: 10,
                      ),
                      Container(
                          width: 60,
                          child: StatefulBuilder(
                            builder: (context, setState1) {
                              return IconButton(
                                color: Colors.white.withOpacity(0.9),
                                iconSize: 50,
                                onPressed: () {
                                  setState1(() {
                                    setState(() {
                                      musicaction();
                                    });
                                  });
                                },
                                splashRadius: 20,
                                tooltip: isPlaying ? "Play" : "Pause",
                                icon: isPlaying
                                    ? Icon(Icons.play_arrow)
                                    : Icon(Icons.pause),
                              );
                            },
                          ))
                    ],
                  ),
                ),
                SizedBox(
                  height: 150,
                ),
                AnimatedButton(
                    color: Colors.red.withOpacity(0.7),
                    height: 60,
                    width: 200,
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: DefaultTextStyle(
                        style: TextStyle(fontSize: 30), child: Text("CLOSE"))),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<bool> showExitPopup(context) async {
    return await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Container(
            height: 90,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Do you want to exit?"),
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pushReplacement(context, MaterialPageRoute(
                            builder: (context) {
                              return HomePage();
                            },
                          ));
                        },
                        child: Text("Yes"),
                        style: ElevatedButton.styleFrom(
                            primary: Colors.red.shade800),
                      ),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    Expanded(
                        child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text(
                        'No',
                        style: TextStyle(color: Colors.black),
                      ),
                      style: ElevatedButton.styleFrom(primary: Colors.white),
                    ))
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }

  Map map = {};

  void win() {
    controller.play();
    showDialog(
      context: context,
      builder: (context) {
        return BlurContainerWidget(
          child: Center(
            child: Container(
              margin: EdgeInsets.fromLTRB(30, 70, 30, 70),
              //  color: Colors.yellowAccent,
              child: Column(
                children: [
                  AnimatedTextKit(
                    animatedTexts: [
                      TyperAnimatedText("YOU ARE WIN !!",
                          speed: Duration(milliseconds: 100),
                          textStyle: TextStyle(
                              color: Colors.yellowAccent,
                              shadows: [
                                Shadow(color: Colors.white, blurRadius: 20)
                              ],
                              fontSize: 30,
                              fontWeight: FontWeight.bold))
                    ],
                    isRepeatingAnimation: true,
                    repeatForever: true,
                    displayFullTextOnTap: true,
                    stopPauseOnTap: false,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 250,
                    width: 200,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage("images/trophy.png"),
                            fit: BoxFit.fill)),
                  ),
                  SizedBox(
                    height: 80,
                  ),
                  AnimatedButton(
                      color: Colors.green.withOpacity(0.7),
                      height: 50,
                      width: 200,
                      onPressed: () {
                        _initImages();
                        Navigator.pop(context);
                      },
                      child: DefaultTextStyle(
                          style: TextStyle(fontSize: 30),
                          child: Text("CONTINUE"))),
                  ConfettiWidget(
                    confettiController: controller,
                    shouldLoop: true,
                    blastDirectionality: BlastDirectionality.explosive,
                    emissionFrequency: 0.1,
                    numberOfParticles: 5,
                    maxBlastForce: 10,
                    gravity: 0,
                    // colors: [Colors.black],
                    createParticlePath: (size) {
                      double degToRad(double deg) => deg * (pi / 180.0);

                      const numberOfPoints = 5;
                      final halfWidth = size.width / 2;
                      final externalRadius = halfWidth;
                      final internalRadius = halfWidth / 2.5;
                      final degreesPerStep = degToRad(360 / numberOfPoints);
                      final halfDegreesPerStep = degreesPerStep / 2;
                      final path = Path();
                      final fullAngle = degToRad(360);
                      path.moveTo(size.width, halfWidth);

                      for (double step = 0;
                          step < fullAngle;
                          step += degreesPerStep) {
                        path.lineTo(halfWidth + externalRadius * cos(step),
                            halfWidth + externalRadius * sin(step));
                        path.lineTo(
                            halfWidth +
                                internalRadius * cos(step + halfDegreesPerStep),
                            halfWidth +
                                internalRadius *
                                    sin(step + halfDegreesPerStep));
                      }
                      path.close();
                      return path;
                    },
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void hint() {
    showDialog(
      context: context,
      builder: (context) {
        return Material(
          color: Colors.transparent,
          child: Container(
            margin: EdgeInsets.fromLTRB(50, 180, 50, 220),
            color: Colors.black.withOpacity(0.7),
            child: Column(
              children: [
                Container(
                  alignment: Alignment.topRight,
                  height: 45,
                  width: double.infinity,
                  child: AnimatedButton(
                    color: Colors.red.withOpacity(0.5),
                    height: 45,
                    width: 50,
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage("images/cancel_kid.png"),
                              opacity: 10,
                              scale: 2)),
                    ),
                  ),
                ),
                Container(
                  height: 70,
                  width: double.infinity,
                  child: DefaultTextStyle(
                    style: TextStyle(fontSize: 50),
                    child: Neon(
                      text: 'HINT',
                      color: Colors.red,
                      fontSize: 40,
                      font: NeonFont.Monoton,
                      flickeringText: true,
                      flickeringLetters: [0, 1, 2, 3],
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    flutterTts.setLanguage("en-US");
                    flutterTts.speak("${AnswerList}");
                  },
                  child: Container(
                    height: 55,
                    width: double.infinity,
                    child: DefaultTextStyle(
                        style: TextStyle(fontSize: 25),
                        child: Center(
                          child: Text(
                            "SPEAK LETTER",
                            style: TextStyle(color: Colors.white),
                          ),
                        )),
                  ),
                ),
                InkWell(
                  onTap: () {
                    flutterTts.setLanguage("en-US");
                    flutterTts.speak("${img.split("/")[1].split(".")[0]}");
                  },
                  child: Container(
                    height: 55,
                    width: double.infinity,
                    child: DefaultTextStyle(
                        style: TextStyle(fontSize: 25),
                        child: Center(
                          child: Text(
                            "SPEAK WORD",
                            style: TextStyle(color: Colors.white),
                          ),
                        )),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                AnimatedButton(
                    color: Colors.red.withOpacity(0.7),
                    height: 40,
                    width: 140,
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: DefaultTextStyle(
                        style: TextStyle(fontSize: 25), child: Text("CLOSE"))),
              ],
            ),
          ),
        );
      },
    );
  }

}
