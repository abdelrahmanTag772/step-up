import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:digital_egypt_pioneers/models/shoe_model.dart';
import 'package:equatable/equatable.dart';

abstract class CartDetailState extends Equatable {
  const CartDetailState();

  @override
  List<Object?> get props => [];
}

// Initial state
class CartDetailInitial extends CartDetailState {}

// State while loading the cart's details
class CartDetailLoading extends CartDetailState {}

// State when the cart details and items are successfully loaded
class CartDetailLoaded extends CartDetailState {
  final DocumentSnapshot cart;
  final List<Map<String, dynamic>> collaborators;
  final List<Shoe> items;
  final Map<String, int> itemsMap; // NEW: To store quantities
  final String? actionError;
  final String? actionSuccess;

  const CartDetailLoaded(
      this.cart, {
        required this.collaborators,
        required this.items,
        required this.itemsMap, // NEW
        this.actionError,
        this.actionSuccess,
      });

  @override
  List<Object?> get props => [cart, collaborators, items, itemsMap, actionError, actionSuccess]; // UPDATED

  // A helper method to create a copy of the state with new values
  CartDetailLoaded copyWith({
    DocumentSnapshot? cart,
    List<Map<String, dynamic>>? collaborators,
    String? actionError,
    bool clearActionError = false,
    String? actionSuccess,
    bool clearActionSuccess = false,
    List<Shoe>? items,
    Map<String, int>? itemsMap, // NEW
  }) {
    return CartDetailLoaded(
      cart ?? this.cart,
      collaborators: collaborators ?? this.collaborators,
      items: items ?? this.items,
      itemsMap: itemsMap ?? this.itemsMap, // NEW
      actionError: clearActionError ? null : actionError ?? this.actionError,
      actionSuccess: clearActionSuccess
          ? null
          : actionSuccess ?? this.actionSuccess,
    );
  }
}

// State for any errors that occur
class CartDetailError extends CartDetailState {
  final String message;

  const CartDetailError(this.message);

  @override
  List<Object> get props => [message];
}