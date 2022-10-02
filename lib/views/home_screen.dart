import 'dart:developer';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

import 'model/ItemModel.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var player = AudioCache();
  List<ItemModel> items = [];
  List<ItemModel> items2 = [];
  int score = 0;
  bool gameOver = false;
  initGame() {
    gameOver = false;
    score = 0;
    items = [
      ItemModel(
        name: 'Lion',
        value: 'lion',
        image: 'assets/lion.png',
      ),
      ItemModel(
        name: 'Panda',
        value: 'panda',
        image: 'assets/panda.png',
      ),
      ItemModel(
        name: 'Camel',
        value: 'camel',
        image: 'assets/camel.png',
      ),
      ItemModel(
        name: 'Dog',
        value: 'dog',
        image: 'assets/dog.png',
      ),
      ItemModel(
        name: 'Cat',
        value: 'cat',
        image: 'assets/cat.png',
      ),
      ItemModel(
        name: 'Horse',
        value: 'horse',
        image: 'assets/horse.png',
      ),
      ItemModel(
        name: 'Sheep',
        value: 'sheep',
        image: 'assets/sheep.png',
      ),
      ItemModel(
        name: 'Cow',
        value: 'cow',
        image: 'assets/cow.png',
      ),
      ItemModel(
        name: 'Hen',
        value: 'hen',
        image: 'assets/hen.png',
      ),
      ItemModel(
        name: 'Fox',
        value: 'fox',
        image: 'assets/fox.png',
      ),
    ];
    items2 = List<ItemModel>.from(items);
    items.shuffle();
    items2.shuffle();
  }

  @override
  void initState() {
    super.initState();
    initGame();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width =MediaQuery.of(context).size.width;
    if (items.isEmpty) gameOver = true;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                //============ Score Row =================
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Score : ',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                      ),
                    ),
                    Text(
                      '$score',
                      style: const TextStyle(
                          color: Colors.pink,
                          fontWeight: FontWeight.bold,
                          fontSize: 26),
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                      Column(
                        children: items.map((item)
                        {
                          return Container(
                            margin: EdgeInsets.all(8),
                            child: Draggable<ItemModel>(
                              data: item,
                              childWhenDragging: CircleAvatar(
                                radius: 50,
                                child: Image.asset(
                                  item.image,
                                ),
                              ),
                              //Image that we will drag it
                              feedback: CircleAvatar(
                                radius: 30,
                                child: Image.asset(
                                  item.image,
                                ),
                              ),
                              //The default image we will see
                              child: CircleAvatar(
                                radius: 30,
                                child: Image.asset(
                                  item.image,
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                      Column(
                        children: items2.map((item) {
                          return Container(
                            child:
                            DragTarget<ItemModel>(
                              builder: (context,acceptedItems,rejectedItems){
                                return Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: item.accepting==true?Colors.grey[400]:Colors.grey[200],
                                  ),
                                  alignment: Alignment.center,
                                  height: height/15,
                                  width: width/3,
                                  margin: EdgeInsets.all(8),
                                  child: Text(
                                    item.name,
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 25,
                                        fontWeight: FontWeight.bold
                                    ),

                                  ),
                                );
                              },
                              onLeave: (data){
                                setState(() {
                                  item.accepting=false;
                                });
                              },
                              onWillAccept: (data){
                                setState(() {
                                  item.accepting=true;
                                });
                                return false;
                              },
                              onAccept: (data){
                                if(item.value == data.value){
                                  setState(() {
                                    items.remove(item);
                                    items2.remove(item);
                                  });
                                  score+=10;
                                  item.accepting=false;
                                }else{
                                  setState(() {
                                    score-=5;
                                    item.accepting=false;
                                    player.play('false.wav');
                                  });
                                }
                              },
                            ),
                          );
                        }).toList(),
                      )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}




