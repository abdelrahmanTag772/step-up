// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'en';

  static String m0(shoeName) => "Add \"${shoeName}\" to a list";

  static String m1(amount, listName) => "Added ${amount} to ${listName}";

  static String m2(amount, listName) =>
      "Added ${amount} to new list: ${listName}";

  static String m3(cartName) =>
      "Are you sure you want to delete \"${cartName}\" permanently?";

  static String m4(item) =>
      "${item} has been removed. Press save to confirm changes.";

  static String m5(cartName) =>
      "Are you sure you want to leave \"${cartName}\"? You will lose access unless invited again.";

  static String m6(item) =>
      "Are you sure you want to remove ${item} from this list?";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "add": MessageLookupByLibrary.simpleMessage("Add"),
    "addToCart": MessageLookupByLibrary.simpleMessage("Add to Cart"),
    "addToListTitle": m0,
    "addedToList": m1,
    "addedToNewList": m2,
    "allItemsRemoved": MessageLookupByLibrary.simpleMessage(
      "All items removed.",
    ),
    "amountLabel": MessageLookupByLibrary.simpleMessage("Amount"),
    "appTitle": MessageLookupByLibrary.simpleMessage("Step Up Store"),
    "brandLabel": MessageLookupByLibrary.simpleMessage("Brand"),
    "cancel": MessageLookupByLibrary.simpleMessage("Cancel"),
    "cart": MessageLookupByLibrary.simpleMessage("Cart"),
    "cartEmpty": MessageLookupByLibrary.simpleMessage(
      "This list has no items yet.",
    ),
    "cartLoading": MessageLookupByLibrary.simpleMessage("Loading cart..."),
    "cartSavedSuccessfully": MessageLookupByLibrary.simpleMessage(
      "List saved successfully!",
    ),
    "close": MessageLookupByLibrary.simpleMessage("Close"),
    "collaborators": MessageLookupByLibrary.simpleMessage("Collaborators"),
    "createAndAdd": MessageLookupByLibrary.simpleMessage("Create & Add"),
    "currency": MessageLookupByLibrary.simpleMessage("EGP"),
    "delete": MessageLookupByLibrary.simpleMessage("Delete"),
    "deleteConfirmation": m3,
    "deleteList": MessageLookupByLibrary.simpleMessage("Delete list?"),
    "email": MessageLookupByLibrary.simpleMessage("Email"),
    "enterListName": MessageLookupByLibrary.simpleMessage("Enter list name"),
    "enterUserEmail": MessageLookupByLibrary.simpleMessage("Enter user email"),
    "error": MessageLookupByLibrary.simpleMessage("Error"),
    "errorLoadingProducts": MessageLookupByLibrary.simpleMessage(
      "Error loading products",
    ),
    "featuredShoes": MessageLookupByLibrary.simpleMessage("Featured shoes"),
    "home": MessageLookupByLibrary.simpleMessage("Home"),
    "itemRemoved": m4,
    "leave": MessageLookupByLibrary.simpleMessage("Leave"),
    "leaveConfirmation": m5,
    "leaveList": MessageLookupByLibrary.simpleMessage("Leave list?"),
    "loading": MessageLookupByLibrary.simpleMessage("Loading..."),
    "login": MessageLookupByLibrary.simpleMessage("Login"),
    "loginError": MessageLookupByLibrary.simpleMessage(
      "Login failed. Try again.",
    ),
    "loginRequiredMessage": MessageLookupByLibrary.simpleMessage(
      "Please log in to add items to a list.",
    ),
    "logout": MessageLookupByLibrary.simpleMessage("Logout"),
    "myLists": MessageLookupByLibrary.simpleMessage("My lists"),
    "myShoppingLists": MessageLookupByLibrary.simpleMessage(
      "My shopping lists",
    ),
    "newShoppingList": MessageLookupByLibrary.simpleMessage(
      "New shopping list",
    ),
    "noLists": MessageLookupByLibrary.simpleMessage(
      "No lists in this section.",
    ),
    "notifications": MessageLookupByLibrary.simpleMessage("Notifications"),
    "orCreateNewList": MessageLookupByLibrary.simpleMessage(
      "Or create a new list",
    ),
    "password": MessageLookupByLibrary.simpleMessage("Password"),
    "pressSaveToConfirm": MessageLookupByLibrary.simpleMessage(
      "Press save to confirm changes.",
    ),
    "profile": MessageLookupByLibrary.simpleMessage("Profile"),
    "remove": MessageLookupByLibrary.simpleMessage("Remove"),
    "removeItem": MessageLookupByLibrary.simpleMessage("Remove item?"),
    "removeItemConfirm": m6,
    "save": MessageLookupByLibrary.simpleMessage("Save"),
    "searchHint": MessageLookupByLibrary.simpleMessage("Search shoes..."),
    "share": MessageLookupByLibrary.simpleMessage("Share"),
    "shareList": MessageLookupByLibrary.simpleMessage("Share list"),
    "sharedWithMe": MessageLookupByLibrary.simpleMessage("Shared with me"),
    "shoppingCart": MessageLookupByLibrary.simpleMessage("Shopping cart"),
    "signIn": MessageLookupByLibrary.simpleMessage("Sign In"),
    "signUp": MessageLookupByLibrary.simpleMessage("Sign Up"),
    "unnamedList": MessageLookupByLibrary.simpleMessage("Unnamed list"),
    "welcome": MessageLookupByLibrary.simpleMessage("Welcome to Step Up app"),
    "welcomeToYourCarts": MessageLookupByLibrary.simpleMessage(
      "Welcome to your shopping lists!",
    ),
  };
}
