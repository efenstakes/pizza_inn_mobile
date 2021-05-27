import 'package:flutter/foundation.dart';
import 'package:pizza_inn_fc/models/food.dart';


class CartProvider extends ChangeNotifier {
  List<Food> cart = [];


  void addToCart({ @required Food food }) {
    print('_addToCart');
    List<Food> matches = cart.where((f) => f.id == food.id).toList();

    bool exists = matches.length > 0;
    
    List<Food> others = cart.where((f) => f.id != food.id).toList();
     
    if( exists ) {
      food = food.setQuantity(food.quantity+1);
      
      cart = [ ...others, food ];
      notifyListeners();
      return;
    }

    cart = [ ...others, food ];
    notifyListeners();
  }// _addToCart

  void removeFromCart({ @required Food food }) {
    print('_removeFromCart');
    List<Food> others = cart.where((f) => f.id != food.id).toList();

    // others.forEach((e) => print(e.id));

    cart = others;
    notifyListeners();  
  }// _removeFromCart

  void reduceFromCart({ @required Food food }) {
    print('_reduceFromCart');
    List<Food> others = cart.where((f) => f.id != food.id).toList();
    
    food = food.setQuantity(food.quantity-1);

    // others.forEach((e) => print(e.id));

    if( food.quantity == 0 ) {
      cart = others; 
    } else {
      cart = [ ...others, food ]; 
    }   
    notifyListeners();
  }// _reduceFromCart

}