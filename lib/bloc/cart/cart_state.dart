import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

abstract class CartState extends Equatable {
  const CartState();

  @override
  List<Object?> get props => [];
}

class CartsInitial extends CartState {}

class CartsLoading extends CartState {}

class CartsLoaded extends CartState {
  final List<QueryDocumentSnapshot> ownedCarts;
  final List<QueryDocumentSnapshot> sharedCarts;
  final String? actionError; // NEW
  final String? actionSuccess; // NEW

  const CartsLoaded({
    required this.ownedCarts,
    required this.sharedCarts,
    this.actionError, // NEW
    this.actionSuccess, // NEW
  });

  @override
  List<Object?> get props =>
      [ownedCarts, sharedCarts, actionError, actionSuccess]; // UPDATED

  // NEW: copyWith method
  CartsLoaded copyWith({
    List<QueryDocumentSnapshot>? ownedCarts,
    List<QueryDocumentSnapshot>? sharedCarts,
    String? actionError,
    bool clearActionError = false,
    String? actionSuccess,
    bool clearActionSuccess = false,
  }) {
    return CartsLoaded(
      ownedCarts: ownedCarts ?? this.ownedCarts,
      sharedCarts: sharedCarts ?? this.sharedCarts,
      actionError: clearActionError ? null : actionError ?? this.actionError,
      actionSuccess:
      clearActionSuccess ? null : actionSuccess ?? this.actionSuccess,
    );
  }
}

class CartsError extends CartState {
  final String message;

  const CartsError(this.message);

  @override
  List<Object> get props => [message];
}