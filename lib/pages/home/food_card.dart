import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pizza_inn_fc/models/food.dart';

class FoodCardWidget extends StatelessWidget {
  Food food;
  bool isCurrent;
  Function addToCart;
  Function goToFoodDetails;


  FoodCardWidget({
    @required this.food,
    @required this.isCurrent,
    @required this.addToCart,
    @required this.goToFoodDetails,
  });


  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    return AnimatedContainer(
      duration: Duration(milliseconds: 400),
      curve: Curves.easeInOut,
      margin: EdgeInsets.symmetric(
        horizontal: isCurrent ? 0 : 48,
        vertical: isCurrent ? 0 : 100,
      ),
      decoration: BoxDecoration(
        // color: Colors.red,
      ),
      child: GestureDetector(
        onTap: ()=> goToFoodDetails(food: food),
        child: Column(
          mainAxisAlignment: isCurrent ? MainAxisAlignment.start : MainAxisAlignment.center,
          // crossAxisAlignment: isCurrent ? CrossAxisAlignment.center : CrossAxisAlignment.start,
          children: [

              // image
              Hero(
                tag: food.id,
                child: CircleAvatar(
                  radius: isCurrent ? screenSize.width/3 : screenSize.width/5,
                  backgroundImage: AssetImage(food.image),
                ),
              ),

              SizedBox( height: isCurrent ? 8 : 2 ),

              // name
              Text(
                food.name,
                style: GoogleFonts.wendyOne(
                  fontSize: isCurrent ? 28 : 18,
                ),
              ),

              SizedBox( height: isCurrent ? 4 : 0 ),

              // price
              Text(
                food.price.toStringAsFixed(2),
                style: TextStyle(
                  fontSize: isCurrent ? 18 : 10,
                  fontWeight: FontWeight.w500
                ),
              ),

              SizedBox( height: isCurrent ? 12 : 4 ),

              // fab
              FloatingActionButton(
                mini: isCurrent ? false : true,
                onPressed: ()=> addToCart(food: food),
                child: Icon(Icons.shopping_basket_outlined),
                elevation: 0,
                backgroundColor: Colors.red,
              ),

          ],
        ),
      ),
    );
  }// build
}