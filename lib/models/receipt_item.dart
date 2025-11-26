class ReceiptItem {
  final String id;
  final String receiptId;
  final String name;
  final double quantity;
  final double unitPrice;
  final double lineTotal;

  ReceiptItem({
    required this.id,
    required this.receiptId,
    required this.name,
    this.quantity = 1.0,
    required this.unitPrice,
    required this.lineTotal,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'receiptId': receiptId,
      'name': name,
      'quantity': quantity,
      'unitPrice': unitPrice,
      'lineTotal': lineTotal,
    };
  }

  factory ReceiptItem.fromJson(Map<String, dynamic> json) {
    return ReceiptItem(
      id: json['id'] as String,
      receiptId: json['receiptId'] as String,
      name: json['name'] as String,
      quantity: (json['quantity'] as num).toDouble(),
      unitPrice: (json['unitPrice'] as num).toDouble(),
      lineTotal: (json['lineTotal'] as num).toDouble(),
    );
  }

  ReceiptItem copyWith({
    String? id,
    String? receiptId,
    String? name,
    double? quantity,
    double? unitPrice,
    double? lineTotal,
  }) {
    return ReceiptItem(
      id: id ?? this.id,
      receiptId: receiptId ?? this.receiptId,
      name: name ?? this.name,
      quantity: quantity ?? this.quantity,
      unitPrice: unitPrice ?? this.unitPrice,
      lineTotal: lineTotal ?? this.lineTotal,
    );
  }
}

