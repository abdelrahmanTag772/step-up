import 'package:equatable/equatable.dart';

abstract class CartDetailEvent extends Equatable {
  const CartDetailEvent();

  @override
  List<Object> get props => [];
}

// Event to load the details and items of a specific cart
class LoadCartDetails extends CartDetailEvent {
  final String cartId;

  const LoadCartDetails(this.cartId);

  @override
  List<Object> get props => [cartId];
}

// Event to add a new item to the current cart
class AddProductToCart extends CartDetailEvent {
  final String cartId;
  final String productId;
  final int amount; // NEW

  const AddProductToCart(this.cartId, this.productId, {this.amount = 1}); // UPDATED

  @override
  List<Object> get props => [cartId, productId, amount]; // UPDATED
}

// NEW: Event to save all item quantity changes
class UpdateCartItems extends CartDetailEvent {
  final String cartId;
  final Map<String, int> newItems;

  const UpdateCartItems(this.cartId, this.newItems);

  @override
  List<Object> get props => [cartId, newItems];
}

// Event to share the cart with another user
class ShareCart extends CartDetailEvent {
  final String cartId;
  final String email;

  const ShareCart(this.cartId, this.email);

  @override
  List<Object> get props => [cartId, email];
}

// Event to clear a temporary action error from the state
class ClearActionError extends CartDetailEvent {}

// Event to clear a temporary success message from the state
class ClearActionSuccess extends CartDetailEvent {}