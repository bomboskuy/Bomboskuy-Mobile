import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart' as fbAuth;

import 'firebase_options.dart';
import 'models/models.dart';
import 'screens/login_screen.dart';
import 'screens/register_screen.dart';
import 'screens/products_screen.dart';
import 'screens/cart_screen.dart';
import 'screens/profile_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const BomboskuyApp());
}

class BomboskuyApp extends StatefulWidget {
  const BomboskuyApp({Key? key}) : super(key: key);

  @override
  State<BomboskuyApp> createState() => _BomboskuyAppState();
}

class _BomboskuyAppState extends State<BomboskuyApp> {
  List<Product> _cart = [];
  String _currentScreen = 'products'; // default screen

  void _navigateTo(String screen) {
    setState(() {
      _currentScreen = screen;
    });
  }

  void _addToCart(Product product) {
    setState(() {
      _cart.add(product);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bomboskuy',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Roboto',
        useMaterial3: true,
        colorSchemeSeed: const Color(0xFFF97316),
        brightness: Brightness.light,
      ),
      home: StreamBuilder<fbAuth.User?>(
        stream: fbAuth.FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          }

          final user = snapshot.data;

          if (user == null) {
            // Jika belum login, arahkan ke halaman login
            return LoginScreen(onNavigate: _navigateTo);
          }

          // Jika sudah login, tampilkan screen sesuai navigasi
          switch (_currentScreen) {
            case 'register':
              return RegisterScreen(onNavigate: _navigateTo);
            case 'cart':
              return CartScreen(
                cartItems: _cart,
                onBack: () => _navigateTo('products'),
              );
            case 'profile':
              return ProfileScreen(onNavigate: _navigateTo);
            case 'products':
            default:
              return ProductScreen(
                onNavigate: _navigateTo,
                onAddToCart: _addToCart,
                cartCount: _cart.length,
              );
          }
        },
      ),
    );
  }
}
