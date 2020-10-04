import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nike/Shoe/model/shoe.dart';

class ShoeCard extends StatelessWidget {
  final Shoe myShoe;
  final VoidCallback onTap;

  const ShoeCard({Key key, this.myShoe, @required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double cardHeight = 355.6;
    return InkWell(
      onTap: onTap,
      child: Stack(
        children: <Widget>[
          Hero(
            tag: "background_${myShoe.model}",
            child: Container(
                decoration: BoxDecoration(
                    color: Color(myShoe.color),
                    borderRadius: BorderRadius.circular(10.0)),
                margin: EdgeInsets.only(left: 17.0, right: 17.0, bottom: 17.0),
                height: cardHeight),
          ),
          Positioned(
            child: Container(
              alignment: Alignment.topCenter,
              child: Hero(
                tag: "number_${myShoe.modelNumber}",
                child: Material(
                  color: Colors.transparent,
                  child: Text(
                    myShoe.modelNumber.toString(),
                    style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 135.0,
                        fontFamily: 'Lato',
                        color: Colors.black.withAlpha(18)),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            top: 33.5,
            left: MediaQuery.of(context).size.width / 4.5,
            child: Hero(
              tag: "image_${myShoe.imgPath}",
              child: Container(
                  height: 200,
                  width: 200,
                  decoration: BoxDecoration(
                      image: DecorationImage(image: AssetImage(myShoe.imgPath)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: -45,
                          blurRadius: 60,
                          offset: Offset(10, 20), // changes position of shadow
                        ),
                      ])),
            ),
          ),
          Positioned(
            //top: 240,
            //left: MediaQuery.of(context).size.width / 2,
            child: Center(
              child: Container(
                margin: EdgeInsets.only(top: 240),
                child: Column(
                  //crossAxisAlignment: CrossAxisAlignment.center,
                  //mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      myShoe.model,
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Colors.grey,
                          fontFamily: 'Lato',
                          fontSize: 19),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 14.2),
                      child: Text(
                        '\$' + myShoe.oldPrice.toInt().toString(),
                        style: TextStyle(
                            color: Colors.red,
                            fontSize: 16.5,
                            fontFamily: 'Lato',
                            fontWeight: FontWeight.w400,
                            decoration: TextDecoration.lineThrough),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 10),
                      child: Text(
                        '\$' + myShoe.newPrice.toInt().toString(),
                        style: TextStyle(
                            fontWeight: FontWeight.w900,
                            color: Colors.black,
                            fontFamily: 'Lato',
                            fontSize: 28.0),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            top: cardHeight - 57,
            left: 27.4,
            child: Icon(
              Icons.favorite_border,
              size: 33.5,
              color: Colors.grey,
            ),
          ),
          Positioned(
            top: cardHeight - 57,
            right: 27.4,
            child: Icon(
              Icons.add_shopping_cart,
              size: 33.5,
              color: Colors.grey,
            ),
          )
        ],
      ),
    );
  }
}
