import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nike/Shoe/model/shoe.dart';
import 'package:nike/Shoe/views/shoe_detail.dart';
import 'package:nike/Shoe/widgets/shoe_card.dart';
import 'package:nike/main.dart';

class ShoesList extends StatelessWidget {
  final List<Shoe> shoesList;

  const ShoesList({Key key, this.shoesList}) : super(key: key);
  
  void _onShoePressed(Shoe shoe, BuildContext context) async {
    MyApp.notifierBottomBarVisible.value= false;
    await Navigator.of(context).push(
      PageRouteBuilder(pageBuilder: (context, animation1, animation2){
        return FadeTransition(
          opacity: animation1,
          child: ShoeDetail(shoe)
        );
      })
    );
    MyApp.notifierBottomBarVisible.value= true;
  }

  List<Widget> getShoes(BuildContext context) {
    final List<Widget> myShoes = [
      for (var shoe in shoesList)
        ShoeCard(
          myShoe: shoe,
          onTap: () {
            _onShoePressed(shoe, context);
          },
        )
    ];
    return myShoes;
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: BouncingScrollPhysics(),
      children: getShoes(context),
    );
  }
}
