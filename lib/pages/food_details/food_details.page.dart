import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:pizza_inn_fc/models/food.dart';
import 'package:pizza_inn_fc/providers/cart_provider.dart';
import 'package:provider/provider.dart';

class FoodDetailsPage extends StatefulWidget {
  final Food food;

  FoodDetailsPage({
    @required this.food,
  });
  
  @override
  _FoodDetailsPageState createState() => _FoodDetailsPageState();
}

class _FoodDetailsPageState extends State<FoodDetailsPage> {
  Food food;
  List<String> _sizes = [
    'Medium', 'Large', 'Mega',
  ];
  String _selectedSize = 'Medium';

  CartProvider _cartProvider;

  @override
  void initState() {
    super.initState();
    this.food = widget.food;
  }// initState

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    _cartProvider = Provider.of<CartProvider>(context, listen: false);
    
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Details',
          style: GoogleFonts.wendyOne(),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 16,
        ),
        child: ListView(
          children: [

            SizedBox(height: 40),

            // image
            Hero(
              tag: food.id,
              child: CircleAvatar(
                radius: screenSize.width/3,
                backgroundImage: AssetImage(food.image),
              ),
            ),

            SizedBox(height: 20),

            // name
            Center(
              child: Text(
                food.name,
                style: GoogleFonts.wendyOne(
                  fontSize: 28,
                ),
              ),
            ),

            SizedBox(height: 2),

            Chip(
              label: Text('Deluxe'),
              labelStyle: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
              backgroundColor: Colors.green,
              elevation: 0,
              padding: EdgeInsets.symmetric(
                horizontal: 16, vertical: 4,
              ),
            ),
            
            SizedBox(height: 28),

            // size
            Text(
              'SIZE',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w800,
              ),
            ),
            SizedBox(height: 6),
            Row(
              children: [

                ..._sizes.map((size) {
                  
                  return GestureDetector(
                    onTap: ()=> setState(()=> this._selectedSize = size),
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 20, vertical: 8,
                      ),
                      margin: EdgeInsets.only(right: 10),
                      decoration: BoxDecoration(
                        color: _selectedSize == size ? Colors.orange : Colors.white,
                        borderRadius: BorderRadius.circular(40),
                        border: Border.all(
                          color: _selectedSize == size ? Colors.transparent : Colors.orange,
                          width: 1.5,
                        ),
                      ),
                      child: Center(
                        child: Text(
                          size,
                          style: TextStyle(
                            fontSize: 18,
                            color: _selectedSize == size ? Colors.white : Colors.orange,
                          ),
                        ),
                      ),
                    ),
                  );
                }).toList(),

              ],
            ),

            SizedBox(height: 28),
            
            // add - delete, qty, 
            Text(
              'SIZE',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w800,
              ),
            ),
            SizedBox(height: 6),
            Consumer<CartProvider>(
              builder: (ctx, CartProvider cartProvider, _) {
                List<Food> matches = cartProvider.cart.where((f)=> f.id == food.id).toList();

                int qty = 0;
                if( matches.length > 0) {
                  qty = matches[0].quantity;
                }

                return _buildQty(qty);
              },
            ),
            

          ],
        ),
      ),
    );
  }// build



  Widget _buildQty(int qty) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [

            _buildAddOrRemoveBtn(
              text: '+',
              onPressed: ()=> _addToCart(food: food),
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
              onPressed: ()=> _reduceInCart(food: food),
            ),

          ],
        ),
        
        Text(
          (food.price*qty).toStringAsFixed(2),
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),

      ],
    );
  }// _buildQty

  
  Widget _buildAddOrRemoveBtn({ @required String text, @required Function onPressed }) {

    return InkWell(
      onTap: onPressed,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: text == '-' ? 14 : 12, vertical: 4,
        ),
        decoration: BoxDecoration(
          color: Colors.orange,
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



  void _addToCart({ @required Food food }) {
    _cartProvider.addToCart(food: food);
  }// addToCart
  
  void _reduceInCart({ @required Food food }) {
    _cartProvider.reduceFromCart(food: food);
  }// reduceInCart
  


}