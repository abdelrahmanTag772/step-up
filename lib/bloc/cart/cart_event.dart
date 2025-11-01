import 'package:equatable/equatable.dart';

abstract class CartEvent extends Equatable {
  const CartEvent();

  @override
  List<Object> get props => [];
}

// Event to tell the BLoC to load the user's carts
class LoadCarts extends CartEvent {
  final String userId;

  const LoadCarts(this.userId);

  @override
  List<Object> get props => [userId];
}

// Event to tell the BLoC to add a new cart
class AddCart extends CartEvent {
  final String listName;
  final String userId;

  const AddCart(this.listName, this.userId);

  @override
  List<Object> get props => [listName, userId];
}

// Event to add a product to a specific, existing cart
class AddItemToSpecificCart extends CartEvent {
  final String cartId;
  final String productId;
  final int amount;

  const AddItemToSpecificCart({
    required this.cartId,
    required this.productId,
    required this.amount,
  });

  @override
  List<Object> get props => [cartId, productId, amount];
}

// Event to create a new cart AND add a product to it
class CreateCartAndAddItem extends CartEvent {
  final String listName;
  final String userId;
  final String productId;
  final int amount;

  const CreateCartAndAddItem({
    required this.listName,
    required this.userId,
    required this.productId,
    required this.amount,
  });

  @override
  List<Object> get props => [listName, userId, productId, amount];
}

// --- NEW EVENTS ---

// Event to delete a cart (owner only)
class DeleteCart extends CartEvent {
  final String cartId;

  const DeleteCart(this.cartId);

  @override
  List<Object> get props => [cartId];
}

// Event to leave a cart (collaborator only)
class LeaveCart extends CartEvent {
  final String cartId;
  final String userId;

  const LeaveCart(this.cartId, this.userId);

  @override
  List<Object> get props => [cartId, userId];
}

// Event to clear a temporary action error from the state
class ClearCartActionError extends CartEvent {}

// Event to clear a temporary success message from the state
class ClearCartActionSuccess extends CartEvent {}