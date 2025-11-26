import 'receipt_item.dart';

class Receipt {
  final String id;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String imageLocalPath;
  final String? merchantName;
  final DateTime date;
  final double? subtotal;
  final double? vatAmount;
  final double totalAmount;
  final String currency;
  final List<ReceiptItem> items;
  final String? note;

  Receipt({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.imageLocalPath,
    this.merchantName,
    required this.date,
    this.subtotal,
    this.vatAmount,
    required this.totalAmount,
    this.currency = 'TRY',
    required this.items,
    this.note,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'imageLocalPath': imageLocalPath,
      'merchantName': merchantName,
      'date': date.toIso8601String(),
      'subtotal': subtotal,
      'vatAmount': vatAmount,
      'totalAmount': totalAmount,
      'currency': currency,
      'items': items.map((item) => item.toJson()).toList(),
      'note': note,
    };
  }

  factory Receipt.fromJson(Map<String, dynamic> json) {
    return Receipt(
      id: json['id'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      imageLocalPath: json['imageLocalPath'] as String,
      merchantName: json['merchantName'] as String?,
      date: DateTime.parse(json['date'] as String),
      subtotal: json['subtotal'] != null ? (json['subtotal'] as num).toDouble() : null,
      vatAmount: json['vatAmount'] != null ? (json['vatAmount'] as num).toDouble() : null,
      totalAmount: (json['totalAmount'] as num).toDouble(),
      currency: json['currency'] as String? ?? 'TRY',
      items: (json['items'] as List<dynamic>)
          .map((item) => ReceiptItem.fromJson(item as Map<String, dynamic>))
          .toList(),
      note: json['note'] as String?,
    );
  }

  Receipt copyWith({
    String? id,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? imageLocalPath,
    String? merchantName,
    DateTime? date,
    double? subtotal,
    double? vatAmount,
    double? totalAmount,
    String? currency,
    List<ReceiptItem>? items,
    String? note,
  }) {
    return Receipt(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      imageLocalPath: imageLocalPath ?? this.imageLocalPath,
      merchantName: merchantName ?? this.merchantName,
      date: date ?? this.date,
      subtotal: subtotal ?? this.subtotal,
      vatAmount: vatAmount ?? this.vatAmount,
      totalAmount: totalAmount ?? this.totalAmount,
      currency: currency ?? this.currency,
      items: items ?? this.items,
      note: note ?? this.note,
    );
  }
}

// ParsedReceipt - API'den dönen veri için
class ParsedReceipt {
  final String? merchantName;
  final DateTime date;
  final double? subtotal;
  final double? vatAmount;
  final double totalAmount;
  final List<ParsedReceiptItem> items;

  ParsedReceipt({
    this.merchantName,
    required this.date,
    this.subtotal,
    this.vatAmount,
    required this.totalAmount,
    required this.items,
  });

  Map<String, dynamic> toJson() {
    return {
      'merchantName': merchantName,
      'date': date.toIso8601String(),
      'subtotal': subtotal,
      'vatAmount': vatAmount,
      'totalAmount': totalAmount,
      'items': items.map((item) => item.toJson()).toList(),
    };
  }

  factory ParsedReceipt.fromJson(Map<String, dynamic> json) {
    return ParsedReceipt(
      merchantName: json['merchantName'] as String?,
      date: DateTime.parse(json['date'] as String),
      subtotal: json['subtotal'] != null ? (json['subtotal'] as num).toDouble() : null,
      vatAmount: json['vatAmount'] != null ? (json['vatAmount'] as num).toDouble() : null,
      totalAmount: (json['totalAmount'] as num).toDouble(),
      items: (json['items'] as List<dynamic>)
          .map((item) => ParsedReceiptItem.fromJson(item as Map<String, dynamic>))
          .toList(),
    );
  }
}

class ParsedReceiptItem {
  final String name;
  final double quantity;
  final double unitPrice;
  final double lineTotal;

  ParsedReceiptItem({
    required this.name,
    required this.quantity,
    required this.unitPrice,
    required this.lineTotal,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'quantity': quantity,
      'unitPrice': unitPrice,
      'lineTotal': lineTotal,
    };
  }

  factory ParsedReceiptItem.fromJson(Map<String, dynamic> json) {
    return ParsedReceiptItem(
      name: json['name'] as String,
      quantity: (json['quantity'] as num).toDouble(),
      unitPrice: (json['unitPrice'] as num).toDouble(),
      lineTotal: (json['lineTotal'] as num).toDouble(),
    );
  }
}

