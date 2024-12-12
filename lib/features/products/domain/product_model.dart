import 'package:uuid/uuid.dart';

const uuid = Uuid();

class ProductModel {
  final String id;
  final String name;
  final String image;
  final double price;
  final int quantity;

  ProductModel({
    required this.name,
    required this.image,
    required this.price,
    this.quantity = 1,
  }) : id = uuid.v4();
}
