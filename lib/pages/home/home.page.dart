import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pizza_inn_fc/models/food.dart';

import 'package:pizza_inn_fc/data/menu.dart' as menu;
import 'package:pizza_inn_fc/pages/cart/cart.page.dart';
import 'package:pizza_inn_fc/pages/food_details/food_details.page.dart';
import 'package:pizza_inn_fc/pages/home/food_card.dart';
import 'package:pizza_inn_fc/providers/cart_provider.dart';
import 'package:pizza_inn_fc/styles/colors.dart' as colors;
import 'package:provider/provider.dart';


class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  PageController _pageViewController = PageController(
    initialPage: 0,
    viewportFraction: 0.6,
  );
  int _currentIndex = 0;

  String _selectedFilter = 'All';
  bool _showCart = false;

  List<Food> _cart = [];
  List<Food> _displayMenu = menu.menu;


  CartProvider _cartProvider;

  
  @override
  void initState() {
    super.initState();
    
    _pageViewController.addListener(() {
      int newIndex = _pageViewController.page.round();

      if( _currentIndex != newIndex ) {
        setState(()=> _currentIndex = newIndex);
      }
    });
  }// initState

  @override
  Widget build(BuildContext context) {
    _cartProvider = Provider.of<CartProvider>(context, listen: false);

    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: RichText(
            text: TextSpan(
              text: 'Pizza ',
              style: GoogleFonts.wendyOne(
                color: Colors.green,
                fontSize: 18,
              ),
              children: [
                
                TextSpan(
                  text: 'Inn',
                  style: GoogleFonts.wendyOne(
                    color: Colors.red,
                  )
                ),

              ]
            ),
          ),
          actions: [
             
            Consumer<CartProvider>(
              builder: (ctx, CartProvider cartProvider, _) {
                return _buildCartBanner(
                  cartProvider.cart.length,
                );
              },
            ),
            
          ],
          backgroundColor: Colors.white,
          elevation: 0,
        ),
        body: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              
              SizedBox(height: 32),

              // filters
              _buildFilters(),

              SizedBox(height: 32),

              Expanded(
                flex: 1,
                child: _buildMenu(),
              ),
              
            ]
          ),
        )
    );
  }


  Widget _buildFilters() {
    print('_selectedFilter ${_selectedFilter}');
    Widget spacing =  SizedBox(width: 16);
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [

        _buildFilterChip(label: 'All'),
        spacing,
        _buildFilterChip(label: 'Todays Deals'),
        spacing,
        _buildFilterChip(label: 'Deluxe'),
        spacing,
        _buildFilterChip(label: 'Classic'),
        spacing,
        _buildFilterChip(label: 'Drinks'),

      ],
    );
  }// _buildFilters

  Widget _buildFilterChip({ @required String label }) {
    return FilterChip(
      label: Text(label), 
      onSelected: (bool isSelected)=> _onSelectFilter(label),
      selected: label == this._selectedFilter,
      labelStyle: TextStyle(
        color: label == this._selectedFilter ? Colors.white : Colors.grey[800]
      ),
      checkmarkColor: Colors.white,
      selectedColor: Colors.green,
      backgroundColor: label == this._selectedFilter ? Colors.green : Colors.white, 
      elevation: label == this._selectedFilter ? 0 : 1,
    );
  }// _buildFilterChip


  Widget _buildMenu() {
    return PageView.builder(
      scrollDirection: Axis.horizontal,
      controller: _pageViewController,
      itemCount: _displayMenu.length,
      itemBuilder: (BuildContext ctx, int index) {

          return FoodCardWidget(
            food: _displayMenu[index],
            isCurrent: _currentIndex == index,
            addToCart: this._addToCart,
            goToFoodDetails: _goToFoodDetails,
          );
      },
    );
  }// _buildMenu


  Widget _buildCartBanner(int number) {
    return GestureDetector(
      onTap: _viewCart,
      child: Padding(
        padding: const EdgeInsets.all(0),
        child: Container(
          height: 10,
          // width: 40,
          constraints: BoxConstraints(
            maxHeight: 4,
          ),
          padding: EdgeInsets.only(
            left: 8, top: 0, bottom: 0,
          ),
          decoration: BoxDecoration(
            // color: Colors.red,
            borderRadius: BorderRadius.circular(40),
          ),
          child: Row(
            children: [

              Icon(
                Icons.shopping_basket_outlined,
                color: Colors.red,
              ),
              
              CircleAvatar(
                radius: 14,
                backgroundColor: Colors.red,
                child: Text(
                  number.toString(),
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                  ),
                ),
              ),              

            ],
          ),
        ),
      ),
    );
  }// _buildCartBanner



  void _addToCart({ @required Food food }) {
    print('_addToCart');
    _cartProvider.addToCart(food: food);
  }// _addToCart

  void _onSelectFilter(String filter) {
    setState(() {
      this._selectedFilter = filter;
      _currentIndex = 0;
    });

    if( filter == 'All' ) {
      setState(()=> _displayMenu = menu.menu);
      return;
    }
    if( filter == 'Drinks' ) {
      List<Food> drinks = menu.menu.where((f) => f.type == 'Drinks').toList();
      setState(()=> _displayMenu = drinks);
      return;
    }

    List<Food> pizzas = menu.menu.where((f) => f.category == filter).toList();
    setState(()=> _displayMenu = pizzas);
  }// _onSelectFilter

  void _viewCart () {
    print('view cart');
    setState(()=> this._showCart = !this._showCart);
    Navigator.push(
      context, 
      MaterialPageRoute(builder: (ctx) {
        return CartPage( cart: _cart );
      }),
    );
  }// _viewCart


  void _goToFoodDetails({ @required Food food }) {
    print('view food');
    Navigator.push(
      context, 
      MaterialPageRoute(builder: (ctx) {

        return FoodDetailsPage(
          food: food,
        );
      }),
    );
  }// _goToFoodDetails

}