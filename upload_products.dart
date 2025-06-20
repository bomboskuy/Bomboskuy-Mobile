import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:bomboskuy/firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  final firestore = FirebaseFirestore.instance;

  final products = [
    {
      "id": 1,
      "name": "Bomboloni Coklat",
      "price": 10000,
      "image": "assets/images/coklat.jpg",
    },
    {
      "id": 2,
      "name": "Bomboloni tiramisu",
      "price": 10000,
      "image": "assets/images/tiramisu.jpg",
    },
    {
      "id": 3,
      "name": "Bomboloni Strawberry",
      "price": 10000,
      "image": "assets/images/strawberry.jpg",
    },
    {
      "id": 4,
      "name": "Bomboloni Matcha",
      "price": 10000,
      "image": "assets/images/matcha.jpg",
    },
    {
      "id": 5,
      "name": "Bomboloni Keju",
      "price": 10000,
      "image": "assets/images/keju.jpg",
    },
    {
      "id": 6,
      "name": "Bomboloni Original",
      "price": 10000,
      "image": "assets/images/original.jpg",
    },
  ];

  for (var product in products) {
    await firestore.collection('products').add(product);
    print("✔️ Produk '${product['name']}' berhasil diupload.");
  }

  print("✅ Semua produk selesai diupload.");
}
