import 'package:flutter/material.dart';


import 'package:pizza_inn_fc/pages/home/home.page.dart';
import 'package:pizza_inn_fc/providers/cart_provider.dart';
import 'package:provider/provider.dart';


void main()=> runApp(MyApp());


class MyApp extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<CartProvider>(
          create: (ctx)=> CartProvider()
        ),
      ],
      child: MaterialApp(
        title: 'Pizza Inn',
        theme: ThemeData(
          primarySwatch: Colors.green,
        ),
        home: HomePage(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
