// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(
      _current != null,
      'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.',
    );
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(
      instance != null,
      'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?',
    );
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Home`
  String get home {
    return Intl.message('Home', name: 'home', desc: '', args: []);
  }

  /// `Cart`
  String get cart {
    return Intl.message('Cart', name: 'cart', desc: '', args: []);
  }

  /// `Profile`
  String get profile {
    return Intl.message('Profile', name: 'profile', desc: '', args: []);
  }

  /// `Welcome to Step Up app`
  String get welcome {
    return Intl.message(
      'Welcome to Step Up app',
      name: 'welcome',
      desc: '',
      args: [],
    );
  }

  /// `Login`
  String get login {
    return Intl.message('Login', name: 'login', desc: '', args: []);
  }

  /// `Logout`
  String get logout {
    return Intl.message('Logout', name: 'logout', desc: '', args: []);
  }

  /// `Email`
  String get email {
    return Intl.message('Email', name: 'email', desc: '', args: []);
  }

  /// `Password`
  String get password {
    return Intl.message('Password', name: 'password', desc: '', args: []);
  }

  /// `Sign In`
  String get signIn {
    return Intl.message('Sign In', name: 'signIn', desc: '', args: []);
  }

  /// `Sign Up`
  String get signUp {
    return Intl.message('Sign Up', name: 'signUp', desc: '', args: []);
  }

  /// `Login failed. Try again.`
  String get loginError {
    return Intl.message(
      'Login failed. Try again.',
      name: 'loginError',
      desc: '',
      args: [],
    );
  }

  /// `Please log in to add items to a list.`
  String get loginRequiredMessage {
    return Intl.message(
      'Please log in to add items to a list.',
      name: 'loginRequiredMessage',
      desc: '',
      args: [],
    );
  }

  /// `My shopping lists`
  String get myShoppingLists {
    return Intl.message(
      'My shopping lists',
      name: 'myShoppingLists',
      desc: '',
      args: [],
    );
  }

  /// `My lists`
  String get myLists {
    return Intl.message('My lists', name: 'myLists', desc: '', args: []);
  }

  /// `Shared with me`
  String get sharedWithMe {
    return Intl.message(
      'Shared with me',
      name: 'sharedWithMe',
      desc: '',
      args: [],
    );
  }

  /// `Delete list?`
  String get deleteList {
    return Intl.message('Delete list?', name: 'deleteList', desc: '', args: []);
  }

  /// `Leave list?`
  String get leaveList {
    return Intl.message('Leave list?', name: 'leaveList', desc: '', args: []);
  }

  /// `Are you sure you want to delete "{cartName}" permanently?`
  String deleteConfirmation(Object cartName) {
    return Intl.message(
      'Are you sure you want to delete "$cartName" permanently?',
      name: 'deleteConfirmation',
      desc: '',
      args: [cartName],
    );
  }

  /// `Are you sure you want to leave "{cartName}"? You will lose access unless invited again.`
  String leaveConfirmation(Object cartName) {
    return Intl.message(
      'Are you sure you want to leave "$cartName"? You will lose access unless invited again.',
      name: 'leaveConfirmation',
      desc: '',
      args: [cartName],
    );
  }

  /// `Delete`
  String get delete {
    return Intl.message('Delete', name: 'delete', desc: '', args: []);
  }

  /// `Leave`
  String get leave {
    return Intl.message('Leave', name: 'leave', desc: '', args: []);
  }

  /// `Cancel`
  String get cancel {
    return Intl.message('Cancel', name: 'cancel', desc: '', args: []);
  }

  /// `Error`
  String get error {
    return Intl.message('Error', name: 'error', desc: '', args: []);
  }

  /// `Welcome to your shopping lists!`
  String get welcomeToYourCarts {
    return Intl.message(
      'Welcome to your shopping lists!',
      name: 'welcomeToYourCarts',
      desc: '',
      args: [],
    );
  }

  /// `No lists in this section.`
  String get noLists {
    return Intl.message(
      'No lists in this section.',
      name: 'noLists',
      desc: '',
      args: [],
    );
  }

  /// `Unnamed list`
  String get unnamedList {
    return Intl.message(
      'Unnamed list',
      name: 'unnamedList',
      desc: '',
      args: [],
    );
  }

  /// `New shopping list`
  String get newShoppingList {
    return Intl.message(
      'New shopping list',
      name: 'newShoppingList',
      desc: '',
      args: [],
    );
  }

  /// `Enter list name`
  String get enterListName {
    return Intl.message(
      'Enter list name',
      name: 'enterListName',
      desc: '',
      args: [],
    );
  }

  /// `Add`
  String get add {
    return Intl.message('Add', name: 'add', desc: '', args: []);
  }

  /// `Shopping cart`
  String get shoppingCart {
    return Intl.message(
      'Shopping cart',
      name: 'shoppingCart',
      desc: '',
      args: [],
    );
  }

  /// `Save`
  String get save {
    return Intl.message('Save', name: 'save', desc: '', args: []);
  }

  /// `Collaborators`
  String get collaborators {
    return Intl.message(
      'Collaborators',
      name: 'collaborators',
      desc: '',
      args: [],
    );
  }

  /// `Share list`
  String get shareList {
    return Intl.message('Share list', name: 'shareList', desc: '', args: []);
  }

  /// `Enter user email`
  String get enterUserEmail {
    return Intl.message(
      'Enter user email',
      name: 'enterUserEmail',
      desc: '',
      args: [],
    );
  }

  /// `Share`
  String get share {
    return Intl.message('Share', name: 'share', desc: '', args: []);
  }

  /// `Close`
  String get close {
    return Intl.message('Close', name: 'close', desc: '', args: []);
  }

  /// `Remove item?`
  String get removeItem {
    return Intl.message('Remove item?', name: 'removeItem', desc: '', args: []);
  }

  /// `Are you sure you want to remove {item} from this list?`
  String removeItemConfirm(Object item) {
    return Intl.message(
      'Are you sure you want to remove $item from this list?',
      name: 'removeItemConfirm',
      desc: '',
      args: [item],
    );
  }

  /// `Remove`
  String get remove {
    return Intl.message('Remove', name: 'remove', desc: '', args: []);
  }

  /// `{item} has been removed. Press save to confirm changes.`
  String itemRemoved(Object item) {
    return Intl.message(
      '$item has been removed. Press save to confirm changes.',
      name: 'itemRemoved',
      desc: '',
      args: [item],
    );
  }

  /// `List saved successfully!`
  String get cartSavedSuccessfully {
    return Intl.message(
      'List saved successfully!',
      name: 'cartSavedSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `Loading cart...`
  String get cartLoading {
    return Intl.message(
      'Loading cart...',
      name: 'cartLoading',
      desc: '',
      args: [],
    );
  }

  /// `This list has no items yet.`
  String get cartEmpty {
    return Intl.message(
      'This list has no items yet.',
      name: 'cartEmpty',
      desc: '',
      args: [],
    );
  }

  /// `All items removed.`
  String get allItemsRemoved {
    return Intl.message(
      'All items removed.',
      name: 'allItemsRemoved',
      desc: '',
      args: [],
    );
  }

  /// `Press save to confirm changes.`
  String get pressSaveToConfirm {
    return Intl.message(
      'Press save to confirm changes.',
      name: 'pressSaveToConfirm',
      desc: '',
      args: [],
    );
  }

  /// `Step Up Store`
  String get appTitle {
    return Intl.message('Step Up Store', name: 'appTitle', desc: '', args: []);
  }

  /// `Search shoes...`
  String get searchHint {
    return Intl.message(
      'Search shoes...',
      name: 'searchHint',
      desc: '',
      args: [],
    );
  }

  /// `Add "{shoeName}" to a list`
  String addToListTitle(Object shoeName) {
    return Intl.message(
      'Add "$shoeName" to a list',
      name: 'addToListTitle',
      desc: '',
      args: [shoeName],
    );
  }

  /// `Amount`
  String get amountLabel {
    return Intl.message('Amount', name: 'amountLabel', desc: '', args: []);
  }

  /// `Added {amount} to {listName}`
  String addedToList(Object amount, Object listName) {
    return Intl.message(
      'Added $amount to $listName',
      name: 'addedToList',
      desc: '',
      args: [amount, listName],
    );
  }

  /// `Or create a new list`
  String get orCreateNewList {
    return Intl.message(
      'Or create a new list',
      name: 'orCreateNewList',
      desc: '',
      args: [],
    );
  }

  /// `Create & Add`
  String get createAndAdd {
    return Intl.message(
      'Create & Add',
      name: 'createAndAdd',
      desc: '',
      args: [],
    );
  }

  /// `Added {amount} to new list: {listName}`
  String addedToNewList(Object amount, Object listName) {
    return Intl.message(
      'Added $amount to new list: $listName',
      name: 'addedToNewList',
      desc: '',
      args: [amount, listName],
    );
  }

  /// `Featured shoes`
  String get featuredShoes {
    return Intl.message(
      'Featured shoes',
      name: 'featuredShoes',
      desc: '',
      args: [],
    );
  }

  /// `EGP`
  String get currency {
    return Intl.message('EGP', name: 'currency', desc: '', args: []);
  }

  /// `Loading...`
  String get loading {
    return Intl.message('Loading...', name: 'loading', desc: '', args: []);
  }

  /// `Error loading products`
  String get errorLoadingProducts {
    return Intl.message(
      'Error loading products',
      name: 'errorLoadingProducts',
      desc: '',
      args: [],
    );
  }

  /// `Notifications`
  String get notifications {
    return Intl.message(
      'Notifications',
      name: 'notifications',
      desc: '',
      args: [],
    );
  }

  /// `Brand`
  String get brandLabel {
    return Intl.message('Brand', name: 'brandLabel', desc: '', args: []);
  }

  /// `Add to Cart`
  String get addToCart {
    return Intl.message('Add to Cart', name: 'addToCart', desc: '', args: []);
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ar'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
