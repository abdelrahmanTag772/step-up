import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:digital_egypt_pioneers/bloc/cart_detail/cart_detail_event.dart';
import 'package:digital_egypt_pioneers/bloc/cart_detail/cart_detail_state.dart';
import 'package:digital_egypt_pioneers/services/firestore_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:digital_egypt_pioneers/services/product_repository.dart';

class CartDetailBloc extends Bloc<CartDetailEvent, CartDetailState> {
  final FirestoreService firestoreService;
  ProductRepository productRepository;
  StreamSubscription? _cartDetailSubscription;


  CartDetailBloc({required this.firestoreService, required this.productRepository}) : super(CartDetailInitial()) {
    on<LoadCartDetails>((event, emit) {
      _cartDetailSubscription?.cancel();
      _cartDetailSubscription = firestoreService.getCartStreamById(event.cartId).listen(
            (DocumentSnapshot cart) {
          add(_CartDetailUpdated(cart));
        },
        onError: (error) {
          emit(CartDetailError(error.toString()));
        },
      );
    });

    on<_CartDetailUpdated>((event, emit) async {
      final cartData = event.cart.data() as Map<String, dynamic>?;
      if (cartData == null) {
        emit(CartDetailError("Cart data is not available."));
        return;
      }

      // Get the collaborator IDs from the cart
      final collaboratorIds = List<String>.from(cartData['collaborators'] ?? []);

      // Fetch the collaborator data using our new service method
      final collaborators = await firestoreService.getCollaborators(collaboratorIds);

      // UPDATED: Get item IDs and quantities from the map
      final itemsMap = Map<String, int>.from(cartData['items'] ?? {});
      final itemIds = itemsMap.keys.toList();

      final items = await productRepository.getProductsByIds(itemIds);

      // Emit the final state with cart, collaborators, items, and the item map
      emit(CartDetailLoaded(
        event.cart,
        collaborators: collaborators,
        items: items,
        itemsMap: itemsMap, // NEW
      ));
    });

    on<AddProductToCart>((event, emit) async {
      try {
        // UPDATED: Pass the amount to the service
        await firestoreService.addProductToCart(event.cartId, event.productId, event.amount);
      } catch (e) {
        // We can't emit a CartDetailError here as it would replace the Loaded state.
        // Instead, we update the existing state with an actionError.
        if (state is CartDetailLoaded) {
          final currentState = state as CartDetailLoaded;
          emit(currentState.copyWith(actionError: e.toString()));
        }
      }
    });

    // NEW: Handle the save button event
    on<UpdateCartItems>((event, emit) async {
      if (state is CartDetailLoaded) {
        final currentState = state as CartDetailLoaded;
        try {
          await firestoreService.updateCartItems(event.cartId, event.newItems);
          emit(currentState.copyWith(actionSuccess: "Cart saved successfully!"));
        } catch (e) {
          emit(currentState.copyWith(actionError: e.toString()));
        }
      }
    });


    on<ShareCart>((event, emit) async {
      // We only want to update the state if it's already loaded
      if (state is CartDetailLoaded) {
        final currentState = state as CartDetailLoaded;
        try {
          await firestoreService.shareCartWithUser(event.cartId, event.email);
          emit(currentState.copyWith(actionSuccess: "List shared successfully!"));
        } catch (e) {
          // On failure, re-emit the current state but with an error message
          emit(currentState.copyWith(actionError: e.toString()));
        }
      }
    });

    // Event handler for clearing a temporary success
    on<ClearActionSuccess>((event, emit) {
      if (state is CartDetailLoaded) {
        final currentState = state as CartDetailLoaded;
        emit(currentState.copyWith(clearActionSuccess: true));
      }
    });

    // Event handler for clearing a temporary error
    on<ClearActionError>((event, emit) {
      if (state is CartDetailLoaded) {
        final currentState = state as CartDetailLoaded;
        // Emit a copy of the state with the error cleared
        emit(currentState.copyWith(clearActionError: true));
      }
    });
  }

  @override
  Future<void> close() {
    _cartDetailSubscription?.cancel();
    return super.close();
  }
}

// Add a new private event to handle the stream update
class _CartDetailUpdated extends CartDetailEvent {
  final DocumentSnapshot cart;
  const _CartDetailUpdated(this.cart);
}