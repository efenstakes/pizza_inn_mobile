import 'package:flutter/material.dart';
import 'package:pizza_inn_fc/models/food.dart';
import 'package:pizza_inn_fc/providers/cart_provider.dart';
import 'package:provider/provider.dart';


class CartCardWidget extends StatelessWidget {
  final Food food;
  CartProvider _cartProvider;

  CartCardWidget({
    @required this.food,
  });
  
  @override
  Widget build(BuildContext context) {
    _cartProvider = Provider.of<CartProvider>(context, listen: false);
    

    return Container(
      margin: EdgeInsets.only(bottom: 20),
      padding: EdgeInsets.symmetric(
        horizontal: 10,
      ),
      child: Row(
        children: [

          Hero(
            tag: food.id,
            child: CircleAvatar(
              radius: 60,
              backgroundImage: AssetImage(food.image),
            ),
          ),

          SizedBox(width: 18),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                
                // name and delete icon
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [

                    Text(
                      food.name,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w800,
                      ),
                    ),

                    InkWell(
                      child: Icon(Icons.delete_outline_rounded),
                      onTap: ()=> removeFromCart(food: food),
                    ),

                  ],
                ),

                SizedBox(height: 4),

                // price
                Text(
                  food.price.toStringAsFixed(2),
                  style: TextStyle(
                    fontSize: 15,
                  ),
                ),

                SizedBox(height: 12),

                // add - delete, qty, 
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [

                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [

                        _buildAddOrRemoveBtn(
                          text: '+',
                          onPressed: ()=> addToCart(food: food),
                        ),

                        SizedBox(width: 10),
                        Text(
                          food.quantity.toString(),
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                        SizedBox(width: 10),

                        _buildAddOrRemoveBtn(
                          text: '-',
                          onPressed: ()=> reduceInCart(food: food),
                        ),

                      ],
                    ),
                    
                    Text(
                      (food.price*food.quantity).toString(),
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),

                  ],
                ),

              ],
            ),
          ),

        ],
      ),
    );
  }// build


  Widget _buildAddOrRemoveBtn({ @required String text, @required Function onPressed }) {

    return InkWell(
      onTap: onPressed,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 11, vertical: 0,
        ),
        decoration: BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.circular(6),
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 28,
              color: Colors.white,
            ),
          ),
        ), 
      ),
    );
  }// _buildAddOrRemoveBtn



  void addToCart({ @required Food food }) {
    _cartProvider.addToCart(food: food);
  }// addToCart
  
  void reduceInCart({ @required Food food }) {
    _cartProvider.reduceFromCart(food: food);
  }// reduceInCart
  
  void removeFromCart({ @required Food food }) {
    _cartProvider.removeFromCart(food: food);
  }// removeFromCart

}