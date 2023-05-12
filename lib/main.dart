import 'dart:io';

import 'package:animated_button/animated_button.dart';
import 'package:blur_container/blur_container.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:neon/neon.dart';
import 'package:one_pic_one_word/SecPage.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: HomePage(),
  ));
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);

  }

  Widget build(BuildContext context) {
    double theight = MediaQuery.of(context).size.height;

    return WillPopScope( onWillPop: () {
      return  showExitPopup(context);
    },child: Scaffold(
      body: Stack(
        children: [
          Container(
            height: theight,
            width: double.infinity,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("images/backimage.jpg"),
                    fit: BoxFit.fill)),
          ),
          BlurContainerWidget(
            height: theight,
            width: double.infinity,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 65, right: 65, top: 110),
            child: Container(
              height: 230,
              color: Colors.transparent,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        height: 113,
                        width: 113,
                        decoration: BoxDecoration(
                            borderRadius:
                            BorderRadius.only(topLeft: Radius.circular(10)),
                            border: Border.all(
                                width: 3, color: Colors.white.withOpacity(0.4)),
                            image: DecorationImage(
                              image: AssetImage("images/lion.jpg"),
                              fit: BoxFit.fill,
                            )),
                      ),
                      Container(
                        height: 113,
                        width: 113,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(10)),
                            border: Border.all(
                                width: 3, color: Colors.white.withOpacity(0.4)),
                            image: DecorationImage(
                                image: AssetImage("images/dog.jpg"),
                                fit: BoxFit.fill)),
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        height: 113,
                        width: 113,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(10)),
                            border: Border.all(
                                width: 3, color: Colors.white.withOpacity(0.4)),
                            image: DecorationImage(
                                image: AssetImage("images/mobile.webp"),
                                fit: BoxFit.fill)),
                      ),
                      Container(
                        height: 113,
                        width: 113,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                                bottomRight: Radius.circular(10)),
                            border: Border.all(
                                width: 3, color: Colors.white.withOpacity(0.4)),
                            image: DecorationImage(
                                image: AssetImage("images/ring.webp"),
                                fit: BoxFit.fill)),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
          Padding(
              padding: const EdgeInsets.only(left: 80, top: 370),
              child: AnimatedButton(
                  color: Colors.grey.withOpacity(0.7),
                  height: 60,
                  width: 200,
                  onPressed: () {
                    Navigator.pushReplacement(context, MaterialPageRoute(
                      builder: (context) {
                        return SecPage();
                      },
                    ));
                  },
                  child: Neon(
                    text: 'PLAY',
                    color: Colors.red,
                    fontSize: 30,
                    font: NeonFont.NightClub70s,
                    flickeringText: true,
                    flickeringLetters: [0, 1, 2, 3],
                  ))),
          Padding(
              padding: const EdgeInsets.only(left: 80, top: 450),
              child: AnimatedButton(
                  color: Colors.grey.withOpacity(0.7),
                  height: 60,
                  width: 200,
                  onPressed: () {
                    showsetting();
                  },
                  child: Text(
                    "SETTING",
                    style: TextStyle(
                        color: Colors.redAccent.withOpacity(0.8), fontSize: 27),
                  ))),
          Padding(
              padding: const EdgeInsets.only(left: 80, top: 530),
              child: AnimatedButton(
                  color: Colors.grey.withOpacity(0.7),
                  height: 60,
                  width: 200,
                  onPressed: () {
                    showExitPopup(context);
                  },
                  child: Text(
                    "EXIT",
                    style: TextStyle(
                        color: Colors.redAccent.withOpacity(0.8), fontSize: 28),
                  ))),
        ],
      ),
    ));
  }

  void showsetting() {
    showDialog(
      context: context,
      builder: (context) {
        return BlurContainerWidget(
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
              SizedBox(height: 130,),
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
                            style: TextStyle(fontSize: 30), child: Text("Sound")),
                      )
                    ),
                    SizedBox(width: 10,),
                    Container(
                      width: 60,
                      child: Icon(Icons.volume_down_alt,color: Colors.white,size: 40,)
                    )
                  ],
                ),
              ),
              SizedBox(height: 150,),
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
        );
      },
    );
  }

  Future<bool> showExitPopup(context) async {
    return await showDialog(context: context, builder: (context) {
      return AlertDialog(
        content: Container(
          height: 90,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Are You sure Exit This App?"),
              SizedBox(height: 20,),
              Row(
                children: [
                  Expanded(child: ElevatedButton(onPressed: () {
                    print('Yes selected');
                    exit(0);
                  }, child: Text("Yes"),
                    style: ElevatedButton.styleFrom(
                        primary: Colors.red.shade800),
                  ),
                  ),
                  SizedBox(width: 15,),
                  Expanded(child: ElevatedButton(onPressed: () {
                    print('Yes selected');

                    Navigator.of(context).pop();
                  },
                    child: Text('No', style: TextStyle(color: Colors.black),),
                    style: ElevatedButton.styleFrom(
                        primary: Colors.white),))
                ],
              )
            ],
          ),
        ),
      );
    },);
  }
}
