import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pizza_inn_fc/models/food.dart';
import 'package:pizza_inn_fc/pages/cart/cart_card.dart';
import 'package:pizza_inn_fc/providers/cart_provider.dart';
import 'package:provider/provider.dart';

class CartPage extends StatefulWidget {
  final List<Food> cart;

  CartPage({
    @required this.cart,
  });

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Your Cart',
          style: GoogleFonts.wendyOne(),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: Container(
        child: ListView(
          children: [

            SizedBox(height: 40),

            Consumer(
              builder: (ctx, CartProvider cartProvider, _) {
                
                // if empty
                if( cartProvider.cart.length == 0 ) {
                  return _empty();
                }

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ...cartProvider.cart.map((food) {
                      return CartCardWidget(
                        food: food, 
                      );
                    }).toList(),
                  ],
                );
              }
            ),
          
            
          ],
        ),
      ),
    );
  }// build


  Widget _empty() {
    return Container(
      height: MediaQuery.of(context).size.height*.6,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          
          Icon(
            Icons.local_pizza_outlined,
            size: 96,
            color: Colors.green[300],
          ),
          SizedBox(height: 8),
          Text(
            'No Food Selected',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w800,
            ),
          ),
          SizedBox(height: 4),
          Text(
            'Select your favorite food to add it to your cart',
            style: TextStyle(
              fontSize: 18,
            ),
          ),

        ],
      ),
    );
  }// empty

}