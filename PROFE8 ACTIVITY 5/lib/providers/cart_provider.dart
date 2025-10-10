import 'package:flutter/material.dart';

class CartItem {
  final String id;
  final String name;
  final double price;
  int qty;

  CartItem({
    required this.id,
    required this.name,
    required this.price,
    this.qty = 1,
  });
}

class CartProvider extends ChangeNotifier {
  final List<CartItem> _items = [];

  // Available demo products (you can expand / replace)
  final List<CartItem> catalog = [
    CartItem(id: 's_regular', name: 'Regular Haircut', price: 20),
    CartItem(id: 's_premium', name: 'Premium Haircut', price: 35),
    CartItem(id: 's_beard', name: 'Beard Trim', price: 15),
    CartItem(id: 's_color', name: 'Hair Coloring', price: 50),
    CartItem(id: 's_kids', name: 'Kids Haircut', price: 15),
  ];

  List<CartItem> get items => List.unmodifiable(_items);

  void addToCart(CartItem product) {
    final index = _items.indexWhere((p) => p.id == product.id);
    if (index >= 0) {
      _items[index].qty += 1;
    } else {
      _items.add(CartItem(
          id: product.id, name: product.name, price: product.price, qty: 1));
    }
    notifyListeners();
  }

  void removeFromCart(String id) {
    _items.removeWhere((p) => p.id == id);
    notifyListeners();
  }

  void decreaseQty(String id) {
    final index = _items.indexWhere((p) => p.id == id);
    if (index >= 0) {
      if (_items[index].qty > 1) {
        _items[index].qty -= 1;
      } else {
        _items.removeAt(index);
      }
      notifyListeners();
    }
  }

  double get total {
    double sum = 0;
    for (final it in _items) sum += it.price * it.qty;
    return sum;
  }

  int get itemCount {
    int c = 0;
    for (final it in _items) c += it.qty;
    return c;
  }

  void clear() {
    _items.clear();
    notifyListeners();
  }
}
