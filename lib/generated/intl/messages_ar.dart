// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a ar locale. All the
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
  String get localeName => 'ar';

  static String m0(shoeName) => "إضافة \"${shoeName}\" إلى قائمة";

  static String m1(amount, listName) => "تمت إضافة ${amount} إلى ${listName}";

  static String m2(amount, listName) =>
      "تمت إضافة ${amount} إلى القائمة الجديدة: ${listName}";

  static String m3(cartName) =>
      "هل أنت متأكد أنك تريد حذف \"${cartName}\" نهائيًا؟";

  static String m4(item) =>
      "${item} تمت إزالته. اضغط على حفظ لتأكيد التغييرات.";

  static String m5(cartName) =>
      "هل أنت متأكد أنك تريد مغادرة \"${cartName}\"؟ ستفقد الوصول إليها ما لم تتم دعوتك مرة أخرى.";

  static String m6(item) =>
      "هل أنت متأكد أنك تريد إزالة ${item} من هذه القائمة؟";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "add": MessageLookupByLibrary.simpleMessage("إضافة"),
    "addToCart": MessageLookupByLibrary.simpleMessage("إضافة إلى السلة"),
    "addToListTitle": m0,
    "addedToList": m1,
    "addedToNewList": m2,
    "allItemsRemoved": MessageLookupByLibrary.simpleMessage(
      "تمت إزالة جميع العناصر.",
    ),
    "amountLabel": MessageLookupByLibrary.simpleMessage("الكمية"),
    "appTitle": MessageLookupByLibrary.simpleMessage("متجر Step Up"),
    "brandLabel": MessageLookupByLibrary.simpleMessage("الماركة"),
    "cancel": MessageLookupByLibrary.simpleMessage("إلغاء"),
    "cart": MessageLookupByLibrary.simpleMessage("السلة"),
    "cartEmpty": MessageLookupByLibrary.simpleMessage(
      "هذه القائمة لا تحتوي على عناصر بعد.",
    ),
    "cartLoading": MessageLookupByLibrary.simpleMessage("جاري تحميل السلة..."),
    "cartSavedSuccessfully": MessageLookupByLibrary.simpleMessage(
      "تم حفظ القائمة بنجاح!",
    ),
    "close": MessageLookupByLibrary.simpleMessage("إغلاق"),
    "collaborators": MessageLookupByLibrary.simpleMessage("المتعاونون"),
    "createAndAdd": MessageLookupByLibrary.simpleMessage("إنشاء وإضافة"),
    "currency": MessageLookupByLibrary.simpleMessage("ج.م"),
    "delete": MessageLookupByLibrary.simpleMessage("حذف"),
    "deleteConfirmation": m3,
    "deleteList": MessageLookupByLibrary.simpleMessage("حذف القائمة؟"),
    "email": MessageLookupByLibrary.simpleMessage("البريد الإلكتروني"),
    "enterListName": MessageLookupByLibrary.simpleMessage("أدخل اسم القائمة"),
    "enterUserEmail": MessageLookupByLibrary.simpleMessage(
      "أدخل البريد الإلكتروني للمستخدم",
    ),
    "error": MessageLookupByLibrary.simpleMessage("خطأ"),
    "errorLoadingProducts": MessageLookupByLibrary.simpleMessage(
      "حدث خطأ أثناء تحميل المنتجات",
    ),
    "featuredShoes": MessageLookupByLibrary.simpleMessage("الأحذية المميزة"),
    "home": MessageLookupByLibrary.simpleMessage("الرئيسية"),
    "itemRemoved": m4,
    "leave": MessageLookupByLibrary.simpleMessage("مغادرة"),
    "leaveConfirmation": m5,
    "leaveList": MessageLookupByLibrary.simpleMessage("مغادرة القائمة؟"),
    "loading": MessageLookupByLibrary.simpleMessage("جاري التحميل..."),
    "login": MessageLookupByLibrary.simpleMessage("تسجيل الدخول"),
    "loginError": MessageLookupByLibrary.simpleMessage(
      "فشل تسجيل الدخول. حاول مرة أخرى.",
    ),
    "loginRequiredMessage": MessageLookupByLibrary.simpleMessage(
      "الرجاء تسجيل الدخول لإضافة عناصر إلى قائمة.",
    ),
    "logout": MessageLookupByLibrary.simpleMessage("تسجيل الخروج"),
    "myLists": MessageLookupByLibrary.simpleMessage("قوائمي"),
    "myShoppingLists": MessageLookupByLibrary.simpleMessage(
      "قوائم التسوق الخاصة بي",
    ),
    "newShoppingList": MessageLookupByLibrary.simpleMessage("قائمة تسوق جديدة"),
    "noLists": MessageLookupByLibrary.simpleMessage(
      "لا توجد قوائم في هذا القسم.",
    ),
    "notifications": MessageLookupByLibrary.simpleMessage("الإشعارات"),
    "orCreateNewList": MessageLookupByLibrary.simpleMessage(
      "أو أنشئ قائمة جديدة",
    ),
    "password": MessageLookupByLibrary.simpleMessage("كلمة المرور"),
    "pressSaveToConfirm": MessageLookupByLibrary.simpleMessage(
      "اضغط على زر الحفظ لتأكيد التغييرات.",
    ),
    "profile": MessageLookupByLibrary.simpleMessage("الملف الشخصي"),
    "remove": MessageLookupByLibrary.simpleMessage("إزالة"),
    "removeItem": MessageLookupByLibrary.simpleMessage("إزالة العنصر؟"),
    "removeItemConfirm": m6,
    "save": MessageLookupByLibrary.simpleMessage("حفظ"),
    "searchHint": MessageLookupByLibrary.simpleMessage("ابحث عن الأحذية..."),
    "share": MessageLookupByLibrary.simpleMessage("مشاركة"),
    "shareList": MessageLookupByLibrary.simpleMessage("مشاركة القائمة"),
    "sharedWithMe": MessageLookupByLibrary.simpleMessage("مشتركة معي"),
    "shoppingCart": MessageLookupByLibrary.simpleMessage("سلة التسوق"),
    "signIn": MessageLookupByLibrary.simpleMessage("تسجيل الدخول"),
    "signUp": MessageLookupByLibrary.simpleMessage("إنشاء حساب"),
    "unnamedList": MessageLookupByLibrary.simpleMessage("قائمة بدون اسم"),
    "welcome": MessageLookupByLibrary.simpleMessage(
      "مرحبًا بك في تطبيق Step Up",
    ),
    "welcomeToYourCarts": MessageLookupByLibrary.simpleMessage(
      "مرحبًا بك في قوائم التسوق الخاصة بك!",
    ),
  };
}
