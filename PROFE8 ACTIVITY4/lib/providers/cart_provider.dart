import 'package:flutter/foundation.dart';
import '../models/cart_item.dart';

class CartProvider with ChangeNotifier {
  final List<CartItem> _items = [];

  List<CartItem> get items => [..._items];

  int get itemCount => _items.length;

  double get totalAmount {
    return _items.fold(0.0, (sum, item) => sum + item.totalPrice);
  }

  void addItem(String productId, String name, double price, String imageUrl) {
    final existingIndex = _items.indexWhere((item) => item.id == productId);
    
    if (existingIndex >= 0) {
      _items[existingIndex].quantity++;
    } else {
      _items.add(CartItem(
        id: productId,
        name: name,
        price: price,
        imageUrl: imageUrl,
      ));
    }
    notifyListeners();
  }

  void removeItem(String productId) {
    _items.removeWhere((item) => item.id == productId);
    notifyListeners();
  }

  void removeSingleItem(String productId) {
    final existingIndex = _items.indexWhere((item) => item.id == productId);
    
    if (existingIndex >= 0) {
      if (_items[existingIndex].quantity > 1) {
        _items[existingIndex].quantity--;
      } else {
        _items.removeAt(existingIndex);
      }
      notifyListeners();
    }
  }

  void clear() {
    _items.clear();
    notifyListeners();
  }
}
