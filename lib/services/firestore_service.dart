import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  // Get instance of Cloud Firestore
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // CREATE: Add a new shopping list for a user
  Future<DocumentReference> createShoppingList(String listName, String userId) async {
    try {
      final docRef = await _db.collection('shoppingLists').add({
        'name': listName,
        'ownerId': userId,
        'collaborators': [userId],
        'createdAt': Timestamp.now(),
        'items': {},
      });
      return docRef;
    } catch (e) {
      print('Error creating shopping list: $e');
      rethrow;
    }
  }

  // READ: Get a real-time stream of all shopping lists for a user
  Stream<QuerySnapshot> getCartsStreamForUser(String userId) {
    return _db
        .collection('shoppingLists')
        .where('collaborators', arrayContains: userId)
        .snapshots();
  }

  // READ: Get a real-time stream for a single cart document
  Stream<DocumentSnapshot> getCartStreamById(String cartId) {
    return _db
        .collection('shoppingLists')
        .doc(cartId)
        .snapshots();
  }

  // UPDATE: Add/Increment a product in a cart's 'items' map
  Future<void> addProductToCart(String cartId, String productId, int amount) async {
    try {
      await _db.collection('shoppingLists').doc(cartId).update({
        'items.$productId': FieldValue.increment(amount),
      });
    } catch (e) {
      print('Error adding item to cart: $e');
      rethrow;
    }
  }

  // NEW: Overwrite the entire 'items' map with new values
  Future<void> updateCartItems(String cartId, Map<String, int> newItems) async {
    try {
      await _db.collection('shoppingLists').doc(cartId).update({
        'items': newItems,
      });
    } catch (e) {
      print('Error updating cart items: $e');
      rethrow;
    }
  }

  // UPDATE: Share a cart with another user by their email
  Future<void> shareCartWithUser(String cartId, String email) async {
    try {
      final querySnapshot = await _db
          .collection('users')
          .where('email', isEqualTo: email)
          .limit(1)
          .get();

      if (querySnapshot.docs.isEmpty) {
        throw Exception('User with that email not found.');
      }

      final userToShareWithId = querySnapshot.docs.first.id;

      await _db.collection('shoppingLists').doc(cartId).update({
        'collaborators': FieldValue.arrayUnion([userToShareWithId]),
      });
    } catch (e) {
      print('Error sharing cart: $e');
      rethrow;
    }
  }

  // READ: Get user details for a list of collaborator IDs
  Future<List<Map<String, dynamic>>> getCollaborators(List<String> userIds) async {
    if (userIds.isEmpty) {
      return [];
    }
    try {
      final querySnapshot = await _db
          .collection('users')
          .where(FieldPath.documentId, whereIn: userIds)
          .get();

      return querySnapshot.docs.map((doc) => doc.data()).toList();
    } catch (e) {
      print("Error getting collaborators: $e");
      rethrow;
    }
  }

  // --- NEW METHODS ---

  // DELETE: Delete a shopping list document by its ID
  Future<void> deleteCart(String cartId) async {
    try {
      await _db.collection('shoppingLists').doc(cartId).delete();
    } catch (e) {
      print('Error deleting cart: $e');
      rethrow;
    }
  }

  // UPDATE: Remove a user from a cart's 'collaborators' array
  Future<void> leaveCart(String cartId, String userId) async {
    try {
      await _db.collection('shoppingLists').doc(cartId).update({
        'collaborators': FieldValue.arrayRemove([userId]),
      });
    } catch (e) {
      print('Error leaving cart: $e');
      rethrow;
    }
  }
}