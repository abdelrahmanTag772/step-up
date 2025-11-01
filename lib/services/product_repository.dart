import 'package:digital_egypt_pioneers/models/shoe_model.dart';

// This is the abstract "contract"
abstract class ProductRepository {
  Future<List<Shoe>> getProducts();
  Future<List<Shoe>> getProductsByIds(List<String> ids);
}

class FakeProductRepository implements ProductRepository {
  final List<Shoe> _allShoes = [
    Shoe(
      id: '1',
      name: 'Step Up Shoe 1',
      brand: 'Nike',
      price: 899.0,
      imageUrl: 'assets/images/shoe1.jpg',
    ),
    Shoe(
      id: '2',
      name: 'Step Up Shoe 2',
      brand: 'Adidas',
      price: 1099.0,
      imageUrl: 'assets/images/shoe2.jpg',
    ),
    Shoe(
      id: '3',
      name: 'Step Up Shoe 3',
      brand: 'Puma',
      price: 999.0,
      imageUrl: 'assets/images/shoe3.jpg',
    ),
    Shoe(
      id: '4',
      name: 'Step Up Shoe 4',
      brand: 'Nike',
      price: 1199.0,
      imageUrl: 'assets/images/shoe4.jpg',
    ),
    Shoe(
      id: '5',
      name: 'Step Up Shoe 5',
      brand: 'Reebok',
      price: 499.0,
      imageUrl: 'assets/images/shoe5.jpg',
    ),
    Shoe(
      id: '6',
      name: 'Step Up Shoe 6',
      brand: 'Adidas',
      price: 1499.0,
      imageUrl: 'assets/images/shoe6.jpg',
    ),
    Shoe(
      id: '7',
      name: 'Step Up Shoe 7',
      brand: 'New Balance',
      price: 799.0,
      imageUrl: 'assets/images/shoe7.jpg',
    ),
    Shoe(
      id: '8',
      name: 'Step Up Shoe 8',
      brand: 'Nike',
      price: 1399.0,
      imageUrl: 'assets/images/shoe8.jpg',
    ),
    Shoe(
      id: '9',
      name: 'Step Up Shoe 9',
      brand: 'Puma',
      price: 899.0,
      imageUrl: 'assets/images/shoe9.jpg',
    ),
    Shoe(
      id: '10',
      name: 'Step Up Shoe 10',
      brand: 'Adidas',
      price: 1599.0,
      imageUrl: 'assets/images/shoe10.jpg',
    ),
  ];
  @override
  Future<List<Shoe>> getProducts() async {
    // Simulate a network delay
    await Future.delayed(const Duration(milliseconds: 500));

    // Return a hard-coded list of fake shoes
    return _allShoes;
  }

  @override
  Future<List<Shoe>> getProductsByIds(List<String> ids) async {
    await Future.delayed(const Duration(milliseconds: 300));
    // Find all shoes in our fake database whose ID is in the provided list
    return _allShoes.where((shoe) => ids.contains(shoe.id)).toList();
  }
}