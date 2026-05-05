class CartItem {
  // Constructor for creating a cart item
  const CartItem({
    required this.id,
    required this.name,
    required this.image,
    required this.price,
    this.quantity = 1,
  });
  final String id;
  final String name;
  final String image;
  final double price;
  final int quantity;

  // Calculates total price
  double get lineTotal => price * quantity;

  // Creates a new instance with updated values (immutability pattern)
  CartItem copyWith({
    String? id,
    String? name,
    String? image,
    double? price,
    int? quantity,
  }) {
    return CartItem(
      id: id ?? this.id,
      name: name ?? this.name,
      image: image ?? this.image,
      price: price ?? this.price,
      quantity: quantity ?? this.quantity,
    );
  }

  // Converts the object to JSON for storage (SharedPreferences)
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'image': image,
      'price': price,
      'quantity': quantity,
    };
  }

  // Creates a CartItem object from JSON data
  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      id: json['id'] as String,
      name: json['name'] as String,
      image: json['image'] as String,
      price: (json['price'] as num).toDouble(),
      quantity: json['quantity'] as int,
    );
  }
}
