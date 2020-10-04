import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nike/Shoe/views/shoe_detail.dart';
import 'package:nike/Shoe/widgets/shoes_list.dart';

import 'Shoe/model/shoe.dart';
import 'Shoe/widgets/shoe_card.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarBrightness: Brightness.light));
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  static final ValueNotifier<bool> notifierBottomBarVisible =
      ValueNotifier(true);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'My Nike Store',
        theme: ThemeData(
          // This is the theme of your application.
          //
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or simply save your changes to "hot reload" in a Flutter IDE).
          // Notice that the counter didn't reset back to zero; the application
          // is not restarted.
          primarySwatch: Colors.blue,
          // This makes the visual density adapt to the platform that you run
          // the app on. For desktop platforms, the controls will be smaller and
          // closer together (more dense) than on mobile platforms.
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: NikeApp());
  }
}

class NikeApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
        body: Stack(
      children: <Widget>[
        Positioned(
          top: 49,
          height: 75,
          width: screenWidth,
          child: Container(
            margin: EdgeInsets.only(bottom: 9.5),
            //height: 1000,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('./assets/shoes/nike_logo.png'))),
          ),
        ),
        Positioned(
            top: 105,
            height: screenHeight - 110,
            width: screenWidth,
            child: ShoesList(shoesList: myShoes)),
        ValueListenableBuilder(
          valueListenable: MyApp.notifierBottomBarVisible,
          child: Container(
            color: Colors.white.withOpacity(0.47),
            child: Container(
              decoration: BoxDecoration(
                  border: Border(
                      top: BorderSide(
                          color: Colors.grey.withAlpha(120), width: 1.35))),
              child: Padding(
                padding: const EdgeInsets.only(left: 30.0, right: 30.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Icon(Icons.home),
                    Icon(Icons.search),
                    Icon(Icons.favorite_border),
                    Icon(Icons.card_travel),
                    CircleAvatar(
                      radius: 17,
                      backgroundImage: AssetImage('./assets/shoes/pp.jpg'),
                    )
                  ],
                ),
              ),
            ),
          ),
          builder: (context, value, child) {
            return AnimatedPositioned(
                duration: Duration(milliseconds: 200),
                width: screenWidth,
                bottom: value ? 0.0 : -kToolbarHeight,
                height: kToolbarHeight,
                child: child);
          },
        )
      ],
    ));
  }
}

final List<Shoe> myShoes = [
  Shoe('AIR MAX 90 EZ Green', 299.0, 149.0, 90, 0xFFEBFFEA,
      './assets/shoes/shoe1_1.png', ['8', '9', '10', '11', '12']),
  Shoe('AIR MAX 90 EZ Blue', 399.0, 149.0, 100, 0xFFEBF1FF,
      './assets/shoes/shoe2_1.png', ['8', '9', '10', '11', '12']),
  Shoe('AIR MAX 90 EZ Black', 399.0, 149.0, 110, 0xFFF1EDED,
      './assets/shoes/shoe3_1.png', ['8', '9', '10', '11', '12']),
];
