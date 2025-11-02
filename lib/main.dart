import 'package:digital_egypt_pioneers/bloc/cart/cart_bloc.dart';
import 'package:digital_egypt_pioneers/bloc/cart/cart_event.dart';
import 'package:digital_egypt_pioneers/bloc/product/product_bloc.dart';
import 'package:digital_egypt_pioneers/bloc/product/product_event.dart';
import 'package:digital_egypt_pioneers/screens/CartListScreen.dart';
import 'package:digital_egypt_pioneers/screens/HomeScreen.dart';
import 'package:digital_egypt_pioneers/screens/ProfileScreen.dart';
import 'package:digital_egypt_pioneers/services/product_repository.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:digital_egypt_pioneers/bloc/auth/auth_bloc.dart';
import 'package:digital_egypt_pioneers/bloc/auth/auth_state.dart';
import 'package:digital_egypt_pioneers/screens/login_page.dart';
import 'package:digital_egypt_pioneers/services/auth_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:digital_egypt_pioneers/services/firestore_service.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'generated/l10n.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Locale _locale = const Locale('ar'); // اللغة الافتراضية

  void setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  @override
  Widget build(BuildContext context) {
    final authRepository = AuthRepository();

    return BlocProvider<AuthBloc>(
      create: (context) => AuthBloc(authRepository: authRepository),
      child: MaterialApp(
        locale: _locale,
        localizationsDelegates: const [
          S.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: S.delegate.supportedLocales,
        debugShowCheckedModeBanner: false,
        title: 'Step Up APP',
        theme: ThemeData.dark().copyWith(
          scaffoldBackgroundColor: const Color(0xFF1F1F21),
        ),
        home: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            if (state is Authenticated) {
              return MultiBlocProvider(
                providers: [
                  BlocProvider<CartBloc>(
                    create: (context) => CartBloc(
                      firestoreService: FirestoreService(),
                    )..add(LoadCarts(state.user.uid)),
                  ),
                  BlocProvider<ProductBloc>(
                    create: (context) => ProductBloc(
                      productRepository: FakeProductRepository(),
                    )..add(LoadProducts()),
                  ),
                ],
                child: MainScreen(setLocale: setLocale),
              );
            }
            return LoginPage(setLocale: setLocale);
          },
        ),
      ),
    );
  }
}

class MainScreen extends StatefulWidget {
  final Function(Locale) setLocale;
  const MainScreen({super.key, required this.setLocale});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final _widgetOptions = <Widget>[
      const Homescreen(),
      const CartListScreen(),
      ProfileScreen(setLocale: widget.setLocale),
    ];

    return Scaffold(
      body: Center(child: _widgetOptions.elementAt(_selectedIndex)),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: const Icon(Icons.home),
            label: S.of(context).home,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.shopping_cart),
            label: S.of(context).cart,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.person),
            label: S.of(context).profile,
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: (index) => setState(() => _selectedIndex = index),
        backgroundColor: const Color(0xFF1F1F21),
        unselectedItemColor: Colors.white,
      ),
    );
  }
}
