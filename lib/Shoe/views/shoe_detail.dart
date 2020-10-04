import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nike/Shoe/model/shoe.dart';
import 'package:nike/Shoe/views/shoe_cart.dart';
import 'package:nike/Shoe/widgets/shake_transition.dart';

class ShoeDetail extends StatelessWidget {
  final ValueNotifier<bool> bottomIconsNotifier = ValueNotifier(false);
  final Shoe myShoe;

  ShoeDetail(this.myShoe);

  Widget _buildCarousel(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SizedBox(
      height: size.height * 0.53,
      child: Stack(
        children: <Widget>[
          Hero(
              tag: 'background_${myShoe.model}',
              child: Container(color: Color(myShoe.color))),
          Positioned(
            top: 0,
            right: 80,
            left: 80,
            child: ShakeTransition(
              axis: Axis.vertical,
              duration: Duration(milliseconds: 1400),
              offset: 150,
              child: Hero(
                tag: 'number_${myShoe.modelNumber}',
                child: Material(
                  color: Colors.transparent,
                  child: FittedBox(
                    child: Text(
                      myShoe.modelNumber.toString(),
                      style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 15.0,
                          color: Colors.black.withAlpha(18)),
                    ),
                  ),
                ),
              ),
            ),
          ),
          // PageView.builder(itemBuilder: (context, index) {
          //   return Container(
          //     margin: EdgeInsets.all(100),
          //     child: Image.asset(
          //       myShoe.imgPath,
          //       width: 10,
          //       height: 10,
          //     ),
          //   );
          // })
          Center(
              child: Hero(
            tag: 'image_${myShoe.imgPath}',
            child: Image.asset(
              myShoe.imgPath,
              height: 250,
              width: 250,
            ),
          ))
        ],
      ),
    );
  }

  List<Widget> _buildSizes() {
    List<Widget> shoeSizes = [];
    myShoe.sizes.forEach((size) {
      shoeSizes.add(_ShoeSize(
        text: size,
      ));
    });
    return shoeSizes;
  }

  void _openShoppingCart(BuildContext context) async {
    bottomIconsNotifier.value = false;
    await Navigator.of(context).push(PageRouteBuilder(
      opaque: false,
      pageBuilder: (context, animation, secondaryAnimation) {
        return FadeTransition(
            opacity: animation,
            child: ShoeCart(
              myShoe: myShoe,
            ));
      },
    ));
    bottomIconsNotifier.value = true;
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      bottomIconsNotifier.value = true;
    });

    const myDuration = Duration(milliseconds: 1000);

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Image.asset(
          './assets/shoes/nike_logo.png',
          height: 40,
        ),
        leading: BackButton(color: Colors.black),
      ),
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Positioned.fill(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                _buildCarousel(context),
                ShakeTransition(
                  child: Padding(
                    padding: const EdgeInsets.all(22.68),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(myShoe.model,
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                              fontFamily: 'Lato',
                              fontSize: 20,
                            )),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: <Widget>[
                            Text('\$' + myShoe.oldPrice.toInt().toString(),
                                style: TextStyle(
                                  color: Colors.red,
                                  decoration: TextDecoration.lineThrough,
                                  fontFamily: 'Lato',
                                  fontSize: 15,
                                )),
                            Text('\$' + myShoe.newPrice.toInt().toString(),
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w900,
                                  fontFamily: 'Lato',
                                  fontSize: 22,
                                )),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                ShakeTransition(
                  duration: myDuration,
                  child: Padding(
                      padding: EdgeInsets.only(top: 6.69, left: 22.68),
                      child: Text(
                        'AVAILABLE SIZES',
                        style: TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.w700,
                            fontSize: 16.5),
                      )),
                ),
                SizedBox(height: 20),
                ShakeTransition(
                  duration: myDuration,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 22.68, right: 22.68),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: _buildSizes()),
                  ),
                ),
                SizedBox(height: 20),
                ShakeTransition(
                  duration: myDuration,
                  child: Padding(
                      padding: EdgeInsets.only(left: 22.68),
                      child: Text(
                        'DESCRIPTION',
                        style: TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.w700,
                            fontSize: 16.5),
                      )),
                ),
              ],
            ),
          ),
          ValueListenableBuilder<bool>(
              valueListenable: bottomIconsNotifier,
              child: Padding(
                padding:
                    const EdgeInsets.only(left: 22.0, right: 22.0, bottom: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    FloatingActionButton(
                      onPressed: null,
                      heroTag: 'fav-1',
                      backgroundColor: Colors.white,
                      child: Icon(Icons.favorite_border, color: Colors.black),
                      mini: true,
                    ),
                    FloatingActionButton(
                      onPressed: () {
                        _openShoppingCart(context);
                      },
                      heroTag: 'fav-2',
                      backgroundColor: Colors.black,
                      child: Icon(Icons.shopping_cart, color: Colors.white),
                    )
                  ],
                ),
              ),
              builder: (context, value, child) {
                return AnimatedPositioned(
                    duration: Duration(milliseconds: 200),
                    bottom: value ? 0 : -kToolbarHeight * 2,
                    left: 0,
                    right: 0,
                    child: child);
              }),
        ],
      ),
    );
  }
}

class _ShoeSize extends StatelessWidget {
  final String text;

  const _ShoeSize({Key key, @required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.all(5),
        child: Text(
          'US ${text}',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12.5),
        ));
  }
}
