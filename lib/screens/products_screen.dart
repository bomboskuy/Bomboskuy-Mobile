import 'package:flutter/material.dart';
import '../models/models.dart';

class ProductScreen extends StatefulWidget {
  final Function(String) onNavigate;
  final Function(Product) onAddToCart;
  final int cartCount;

  const ProductScreen({
    Key? key,
    required this.onNavigate,
    required this.onAddToCart,
    required this.cartCount,
  }) : super(key: key);

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  final List<Product> products = [
    Product(id: 1, name: "Bomboloni Coklat", price: 15000, image: "assets/images/coklat.jpg"),
    Product(id: 2, name: "Bomboloni Vanilla", price: 15000, image: "assets/images/vanilla.jpg"),
    Product(id: 3, name: "Bomboloni Strawberry", price: 15000, image: "assets/images/strawberry.jpg"),
    Product(id: 4, name: "Bomboloni Blueberry", price: 15000, image: "assets/images/blueberry.jpg"),
    Product(id: 5, name: "Bomboloni Keju", price: 15000, image: "assets/images/keju.jpg"),
    Product(id: 6, name: "Bomboloni Pisang", price: 15000, image: "assets/images/pisang.jpg"),
  ];

  String _formatPrice(int price) {
    return price.toString().replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
      (Match m) => '${m[1]}.',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF97316),
      body: Column(
        children: [
          // Header
          Container(
            color: Colors.white,
            padding: const EdgeInsets.only(top: 40, left: 16, right: 16, bottom: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'Bomboskuy',
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xFF1F2937)),
                    ),
                    Text(
                      'Bomboloni Terenak di Kota',
                      style: TextStyle(fontSize: 12, color: Color(0xFF6B7280)),
                    ),
                  ],
                ),
                Row(
                  children: [
                    GestureDetector(
                      onTap: () => widget.onNavigate("cart"),
                      child: Stack(
                        children: [
                          Container(
                            margin: const EdgeInsets.only(right: 12),
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: const Color(0xFFFED7AA),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: const Icon(Icons.shopping_cart, size: 20, color: Color(0xFFEA580C)),
                          ),
                          if (widget.cartCount > 0)
                            Positioned(
                              right: 0,
                              top: 0,
                              child: Container(
                                padding: const EdgeInsets.all(4),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFEF4444),
                                  shape: BoxShape.circle,
                                ),
                                child: Text(
                                  '${widget.cartCount}',
                                  style: const TextStyle(color: Colors.white, fontSize: 10),
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () => widget.onNavigate("profile"),
                      child: Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: const Color(0xFFFED7AA),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Icon(Icons.person, size: 20, color: Color(0xFFEA580C)),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          // Product Grid
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Menu Bomboloni',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                  const SizedBox(height: 16),
                  Expanded(
                    child: GridView.builder(
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 16,
                        mainAxisSpacing: 16,
                        childAspectRatio: 0.75,
                      ),
                      itemCount: products.length,
                      itemBuilder: (context, index) {
                        final product = products[index];
                        return Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                blurRadius: 8,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          padding: const EdgeInsets.all(12),
                          child: Column(
                            children: [
                              Expanded(
                                flex: 3,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(12),
                                  child: Image.asset(
                                    product.image,
                                    fit: BoxFit.cover,
                                    width: double.infinity,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                product.name,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xFF1F2937),
                                  fontSize: 14,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              Text(
                                'Rp ${_formatPrice(product.price)}',
                                style: const TextStyle(
                                  color: Color(0xFFEA580C),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                              ),
                              const SizedBox(height: 8),
                              SizedBox(
                                width: double.infinity,
                                child: ElevatedButton(
                                  onPressed: () => widget.onAddToCart(product),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xFFF97316),
                                    foregroundColor: Colors.white,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                  ),
                                  child: const Text(
                                    'Tambah ke Keranjang',
                                    style: TextStyle(fontSize: 12),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
