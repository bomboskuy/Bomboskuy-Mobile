import 'package:flutter/material.dart';
import '../models/models.dart' as model;

class CartScreen extends StatefulWidget {
  final List<model.Product> cartItems;
  final VoidCallback onBack;

  const CartScreen({
    super.key,
    required this.cartItems,
    required this.onBack,
  });

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  late Map<int, Map<String, dynamic>> _groupedCart;

  @override
  void initState() {
    super.initState();
    _groupCartItems();
  }

  void _groupCartItems() {
    _groupedCart = {};
    for (var item in widget.cartItems) {
      if (_groupedCart.containsKey(item.id)) {
        _groupedCart[item.id]!['quantity'] += 1;
      } else {
        _groupedCart[item.id] = {
          'product': item,
          'quantity': 1,
        };
      }
    }
  }

  void _increment(model.Product product) {
    setState(() {
      _groupedCart[product.id]!['quantity'] += 1;
    });
  }

  void _decrement(model.Product product) {
    setState(() {
      if (_groupedCart[product.id]!['quantity'] > 1) {
        _groupedCart[product.id]!['quantity'] -= 1;
      } else {
        _groupedCart.remove(product.id);
      }
    });
  }

  void _checkout() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Pembayaran Berhasil'),
        content: const Text('Terima kasih telah berbelanja di Bomboskuy!'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text('OK'),
          )
        ],
      ),
    );
    setState(() => _groupedCart.clear());
  }

  String _formatPrice(int price) {
    return price.toString().replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
      (Match m) => '${m[1]}.',
    );
  }

  int _calculateTotal() {
    int total = 0;
    _groupedCart.forEach((key, item) {
      final model.Product product = item['product'];
      final int quantity = item['quantity'];
      total += product.price * quantity;
    });
    return total;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Keranjang"),
        backgroundColor: const Color(0xFFF97316),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: widget.onBack,
        ),
      ),
      body: _groupedCart.isEmpty
          ? const Center(child: Text("Keranjang masih kosong"))
          : Column(
              children: [
                Expanded(
                  child: ListView(
                    children: _groupedCart.entries.map((entry) {
                      final model.Product product = entry.value['product'];
                      final int quantity = entry.value['quantity'];
                      return ListTile(
                        leading: Image.asset(product.image, width: 50, height: 50, fit: BoxFit.cover),
                        title: Text(product.name),
                        subtitle: Text('Rp ${_formatPrice(product.price)} x $quantity'),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.remove_circle_outline),
                              onPressed: () => _decrement(product),
                            ),
                            Text('$quantity'),
                            IconButton(
                              icon: const Icon(Icons.add_circle_outline),
                              onPressed: () => _increment(product),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(16),
                  color: Colors.white,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text("Total:", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                          Text("Rp ${_formatPrice(_calculateTotal())}", style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                        ],
                      ),
                      const SizedBox(height: 8),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: _checkout,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFF97316),
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                          ),
                          child: const Text("Checkout"),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}
