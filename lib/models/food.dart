import 'dart:core';



class Food {
  int id;
  String name;
  double price;
  double rating;
  double numRatings;
  String description;
  String image;
  String type;
  String category;

  int quantity;

  Food({
    this.id,
    this.name,
    this.price,
    this.rating = 0,
    this.numRatings = 0,
    this.description,
    this.image,
    this.type = 'pizza',
    this.category,

    this.quantity = 1,
  });

  Food setQuantity(int qty) {
    this.quantity = qty;
    return this;
  }// setQuantity
}