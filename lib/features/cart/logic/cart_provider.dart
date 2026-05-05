import 'dart:convert';
import 'package:ecommerce_app/features/cart/data/cart_item.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartProvider extends ChangeNotifier {
  static const String _storageKey = 'cart_items';

  final List<CartItem> _items = [];

  // Returns an unmodifiable list to prevent external mutation
  List<CartItem> get items => List.unmodifiable(_items);

  // Calculates total number of items (including quantities)
  int get itemCount => _items.fold(0, (total, item) => total + item.quantity);

  // Calculates total price of all items in the cart
  double get totalPrice {
    return _items.fold(0, (total, item) => total + item.lineTotal);
  }

  // Checks if a product exists in the cart by id
  bool contains(String id) {
    return _items.any((item) => item.id == id);
  }

  // Loads cart data from SharedPreferences when app starts
  Future<void> loadCart() async {
    final prefs = await SharedPreferences.getInstance();
    final rawItems = prefs.getString(_storageKey);

    if (rawItems == null || rawItems.isEmpty) {
      return;
    }

    final decodedItems = jsonDecode(rawItems) as List<dynamic>;
    _items
      ..clear()
      ..addAll(
        decodedItems.map(
          (item) => CartItem.fromJson(item as Map<String, dynamic>),
        ),
      );
    notifyListeners();
  }

  // Adds a product to the cart
  // If it already exists, increments its quantity instead
  Future<void> addProduct({
    required String id,
    required String name,
    required String image,
    required double price,
  }) async {
    final index = _items.indexWhere((item) => item.id == id);

    if (index == -1) {
      _items.add(CartItem(id: id, name: name, image: image, price: price));
    } else {
      final currentItem = _items[index];
      _items[index] = currentItem.copyWith(quantity: currentItem.quantity + 1);
    }

    await _persistAndNotify();
  }

  // Removes a product from the cart by id
  Future<void> removeProduct(String id) async {
    _items.removeWhere((item) => item.id == id);
    await _persistAndNotify();
  }

  // Updates the quantity of a specific product
  // If quantity <= 0, the product is removed
  Future<void> updateQuantity(String id, int quantity) async {
    if (quantity <= 0) {
      await removeProduct(id);
      return;
    }

    final index = _items.indexWhere((item) => item.id == id);
    if (index == -1) {
      return;
    }

    _items[index] = _items[index].copyWith(quantity: quantity);
    await _persistAndNotify();
  }

  // Increases product quantity by 1
  Future<void> incrementQuantity(String id) async {
    final index = _items.indexWhere((item) => item.id == id);
    if (index == -1) {
      return;
    }

    await updateQuantity(id, _items[index].quantity + 1);
  }

  // Decreases product quantity by 1
  // Removes the product if quantity becomes 0
  Future<void> decrementQuantity(String id) async {
    final index = _items.indexWhere((item) => item.id == id);
    if (index == -1) {
      return;
    }

    await updateQuantity(id, _items[index].quantity - 1);
  }

  // Clears all items from the cart
  Future<void> clearCart() async {
    _items.clear();
    await _persistAndNotify();
  }

  // Internal helper: saves data and notifies listeners
  Future<void> _persistAndNotify() async {
    await _saveCart();
    notifyListeners();
  }

  // Internal helper: encodes cart to JSON and stores it
  Future<void> _saveCart() async {
    final prefs = await SharedPreferences.getInstance();
    final encodedItems = jsonEncode(
      _items.map((item) => item.toJson()).toList(),
    );
    await prefs.setString(_storageKey, encodedItems);
  }
}
