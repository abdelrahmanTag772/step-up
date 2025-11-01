import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:digital_egypt_pioneers/bloc/cart/cart_event.dart';
import 'package:digital_egypt_pioneers/bloc/cart/cart_state.dart';
import 'package:digital_egypt_pioneers/services/firestore_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final FirestoreService firestoreService;
  StreamSubscription? _cartsSubscription;
  String? _currentUserId;

  CartBloc({required this.firestoreService}) : super(CartsInitial()) {
    on<LoadCarts>((event, emit) {
      emit(CartsLoading());
      _cartsSubscription?.cancel();
      _currentUserId = event.userId;
      _cartsSubscription =
          firestoreService.getCartsStreamForUser(event.userId).listen(
                (QuerySnapshot snapshot) {
              add(_CartsUpdated(snapshot.docs));
            },
            onError: (error) {
              emit(CartsError(error.toString()));
            },
          );
    });

    on<_CartsUpdated>((event, emit) {
      if (_currentUserId == null) return;

      final List<QueryDocumentSnapshot> ownedCarts = [];
      final List<QueryDocumentSnapshot> sharedCarts = [];

      for (var cartDoc in event.carts) {
        final cartData = cartDoc.data() as Map<String, dynamic>;
        if (cartData['ownerId'] == _currentUserId) {
          ownedCarts.add(cartDoc);
        } else {
          sharedCarts.add(cartDoc);
        }
      }

      // UPDATED: Use copyWith if state is already loaded
      if (state is CartsLoaded) {
        final currentState = state as CartsLoaded;
        emit(currentState.copyWith(
          ownedCarts: ownedCarts,
          sharedCarts: sharedCarts,
        ));
      } else {
        emit(CartsLoaded(ownedCarts: ownedCarts, sharedCarts: sharedCarts));
      }
    });

    on<AddCart>((event, emit) async {
      try {
        await firestoreService.createShoppingList(event.listName, event.userId);
      } catch (e) {
        // UPDATED: Error handling
        if (state is CartsLoaded) {
          emit((state as CartsLoaded).copyWith(actionError: e.toString()));
        } else {
          emit(CartsError(e.toString()));
        }
      }
    });

    on<AddItemToSpecificCart>((event, emit) async {
      try {
        await firestoreService.addProductToCart(
            event.cartId, event.productId, event.amount);
      } catch (e) {
        // UPDATED: Error handling
        if (state is CartsLoaded) {
          emit((state as CartsLoaded).copyWith(actionError: e.toString()));
        } else {
          emit(CartsError(e.toString()));
        }
      }
    });

    on<CreateCartAndAddItem>((event, emit) async {
      try {
        final newCartRef = await firestoreService.createShoppingList(
            event.listName, event.userId);
        await firestoreService.addProductToCart(
            newCartRef.id, event.productId, event.amount);
      } catch (e) {
        // UPDATED: Error handling
        if (state is CartsLoaded) {
          emit((state as CartsLoaded).copyWith(actionError: e.toString()));
        } else {
          emit(CartsError(e.toString()));
        }
      }
    });

    // --- NEW HANDLERS ---
    on<DeleteCart>((event, emit) async {
      try {
        await firestoreService.deleteCart(event.cartId);
        // Stream will update the list
      } catch (e) {
        if (state is CartsLoaded) {
          emit((state as CartsLoaded).copyWith(actionError: e.toString()));
        }
      }
    });

    on<LeaveCart>((event, emit) async {
      try {
        await firestoreService.leaveCart(event.cartId, event.userId);
        // Stream will update the list
      } catch (e) {
        if (state is CartsLoaded) {
          emit((state as CartsLoaded).copyWith(actionError: e.toString()));
        }
      }
    });

    on<ClearCartActionError>((event, emit) {
      if (state is CartsLoaded) {
        emit((state as CartsLoaded).copyWith(clearActionError: true));
      }
    });

    on<ClearCartActionSuccess>((event, emit) {
      if (state is CartsLoaded) {
        emit((state as CartsLoaded).copyWith(clearActionSuccess: true));
      }
    });
  }

  @override
  Future<void> close() {
    _cartsSubscription?.cancel();
    return super.close();
  }
}

// Add a new private event to handle stream updates
class _CartsUpdated extends CartEvent {
  final List<QueryDocumentSnapshot> carts;
  const _CartsUpdated(this.carts);
}