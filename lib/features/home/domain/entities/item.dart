class Item {
  final String quantity;
  final String productCode;
  final String description;
  final String size;
  final int price;

  Item({
    required this.quantity,
    required this.productCode,
    required this.description,
    required this.size,
    required this.price,
  });

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      quantity: json['quantity'].toString(),
      productCode: json['product_code'] ?? '',
      description: json['description'] ?? '',
      size: json['size'] ?? '',
      price: json['price'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'quantity': quantity,
      'product_code': productCode,
      'description': description,
      'size': size,
      'price': price,
    };
  }
}
