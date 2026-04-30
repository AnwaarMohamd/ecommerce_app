import 'dart:convert';

import 'package:ecommerce_app/features/cart/data/cart_item.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartProvider extends ChangeNotifier {
  static const String _storageKey = 'cart_items';

  final List<CartItem> _items = [];

  List<CartItem> get items => List.unmodifiable(_items);

  int get itemCount => _items.fold(0, (total, item) => total + item.quantity);

  double get totalPrice {
    return _items.fold(0, (total, item) => total + item.lineTotal);
  }

  bool contains(String id) {
    return _items.any((item) => item.id == id);
  }

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

  Future<void> addProduct({
    required String id,
    required String name,
    required String image,
    required double price,
  }) async {
    final index = _items.indexWhere((item) => item.id == id);

    if (index == -1) {
      _items.add(
        CartItem(id: id, name: name, image: image, price: price),
      );
    } else {
      final currentItem = _items[index];
      _items[index] = currentItem.copyWith(
        quantity: currentItem.quantity + 1,
      );
    }

    await _persistAndNotify();
  }

  Future<void> removeProduct(String id) async {
    _items.removeWhere((item) => item.id == id);
    await _persistAndNotify();
  }

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

  Future<void> incrementQuantity(String id) async {
    final index = _items.indexWhere((item) => item.id == id);
    if (index == -1) {
      return;
    }

    await updateQuantity(id, _items[index].quantity + 1);
  }

  Future<void> decrementQuantity(String id) async {
    final index = _items.indexWhere((item) => item.id == id);
    if (index == -1) {
      return;
    }

    await updateQuantity(id, _items[index].quantity - 1);
  }

  Future<void> clearCart() async {
    _items.clear();
    await _persistAndNotify();
  }

  Future<void> _persistAndNotify() async {
    await _saveCart();
    notifyListeners();
  }

  Future<void> _saveCart() async {
    final prefs = await SharedPreferences.getInstance();
    final encodedItems = jsonEncode(
      _items.map((item) => item.toJson()).toList(),
    );
    await prefs.setString(_storageKey, encodedItems);
  }
}
