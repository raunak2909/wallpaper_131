import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

class ScrollListPage extends StatefulWidget {
  const ScrollListPage({super.key});

  @override
  State<ScrollListPage> createState() => _ScrollListPageState();
}

class _ScrollListPageState extends State<ScrollListPage> {
  late ScrollController mController;

  List<Color> arrColors = [
    Colors.orange,
    Colors.grey,
    Colors.green,
    Colors.purple,
    Colors.yellow,
    Colors.blue,
    Colors.blueGrey,
    Colors.red,
    Colors.indigo,
    Colors.pink,
  ];

  @override
  void initState() {
    super.initState();

    mController = ScrollController();

    mController.addListener(() {
      //print(mController.offset);

      if (mController.position.pixels == mController.position.maxScrollExtent) {
        print("End of List");

          for (int i = 0; i < 10; i++) {
            arrColors.add(Colors
                .primaries[Random().nextInt(Colors.primaries.length - 1)]);
          }
          setState(() {});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('List'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: NotificationListener<ScrollNotification>(
          onNotification: (ScrollNotification notification){

            if(notification is ScrollStartNotification){
              print("Scroll started!!");
            } else if(notification is ScrollUpdateNotification){
              print("Scrolling!!");
            } else if(notification is ScrollEndNotification){
              print("Scroll Ended!!");
            }

            if(notification.metrics.pixels==notification.metrics.extentBefore){
              print("List is about to end!!");
            }

            if(notification.metrics.pixels==notification.metrics.extentAfter){
              print("List is about to end!!");
            }

            return false;
          },
          child: GridView.builder(
              controller: mController,
              itemCount: arrColors.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 11,
                  crossAxisSpacing: 11,
                  childAspectRatio: 9 / 16),
              itemBuilder: (_, index) {
                return Container(
                  color: arrColors[index],
                );
              }),
        ),
      ),
    );
  }
}
