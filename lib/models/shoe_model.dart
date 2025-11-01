import 'package:equatable/equatable.dart';

class Shoe extends Equatable {
  final String id;
  final String name;
  final String brand;
  final double price;
  final String imageUrl;

  const Shoe({
    required this.id,
    required this.name,
    required this.brand,
    required this.price,
    required this.imageUrl,
  });

  @override
  List<Object?> get props => [id, name, brand, price, imageUrl];
}