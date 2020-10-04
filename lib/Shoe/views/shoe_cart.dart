import 'package:flutter/material.dart';
import 'package:nike/Shoe/model/shoe.dart';

class ShoeCart extends StatelessWidget {
  final Shoe myShoe;

  ShoeCart({Key key, @required this.myShoe}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Material(
      color: Colors.black.withAlpha(155),
      child: Stack(
        children: [
          SizedBox(
            height: size.height / 2 - 35,
            child: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: TweenAnimationBuilder(
              tween: Tween(begin: 1.0, end: 0.0),
              duration: Duration(milliseconds: 350),
              curve: Curves.easeIn,
              child: Container(
                height: MediaQuery.of(context).size.height / 2 + 55,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20.0),
                        topRight: Radius.circular(20.0))),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(30.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image.asset(
                            myShoe.imgPath,
                            height: 150,
                            width: 150,
                          ),
                          Spacer(),
                          Padding(
                            padding: EdgeInsets.only(top: 20),
                            //alignment: Alignment.topRight,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  myShoe.model,
                                  style: TextStyle(
                                      color: Colors.grey,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 17.5,
                                      fontFamily: 'Lato'),
                                ),
                                Text(
                                  '\$' + myShoe.newPrice.toInt().toString(),
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w900,
                                      fontSize: 20.0,
                                      fontFamily: 'Lato'),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              builder: (context, value, child) {
                return Transform.translate(
                  offset: Offset(0.0, value * size.height * 0.6),
                  child: child,
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
