import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/receipt.dart';
import '../models/receipt_item.dart';

class DatabaseService {
  static final DatabaseService _instance = DatabaseService._internal();
  factory DatabaseService() => _instance;
  DatabaseService._internal();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'fishle.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    // Receipts table
    await db.execute('''
      CREATE TABLE receipts (
        id TEXT PRIMARY KEY,
        createdAt TEXT NOT NULL,
        updatedAt TEXT NOT NULL,
        imageLocalPath TEXT NOT NULL,
        merchantName TEXT,
        date TEXT NOT NULL,
        subtotal REAL,
        vatAmount REAL,
        totalAmount REAL NOT NULL,
        currency TEXT NOT NULL DEFAULT 'TRY',
        note TEXT
      )
    ''');

    // Receipt items table
    await db.execute('''
      CREATE TABLE receipt_items (
        id TEXT PRIMARY KEY,
        receiptId TEXT NOT NULL,
        name TEXT NOT NULL,
        quantity REAL NOT NULL DEFAULT 1.0,
        unitPrice REAL NOT NULL,
        lineTotal REAL NOT NULL,
        FOREIGN KEY (receiptId) REFERENCES receipts (id) ON DELETE CASCADE
      )
    ''');

    // Indexes for better performance
    await db.execute('CREATE INDEX idx_receipts_date ON receipts(date)');
    await db.execute('CREATE INDEX idx_receipts_createdAt ON receipts(createdAt)');
    await db.execute('CREATE INDEX idx_receipt_items_receiptId ON receipt_items(receiptId)');
  }

  // Receipt operations
  Future<void> saveReceipt(Receipt receipt) async {
    final db = await database;
    await db.transaction((txn) async {
      // Save receipt
      await txn.insert(
        'receipts',
        {
          'id': receipt.id,
          'createdAt': receipt.createdAt.toIso8601String(),
          'updatedAt': receipt.updatedAt.toIso8601String(),
          'imageLocalPath': receipt.imageLocalPath,
          'merchantName': receipt.merchantName,
          'date': receipt.date.toIso8601String(),
          'subtotal': receipt.subtotal,
          'vatAmount': receipt.vatAmount,
          'totalAmount': receipt.totalAmount,
          'currency': receipt.currency,
          'note': receipt.note,
        },
        conflictAlgorithm: ConflictAlgorithm.replace,
      );

      // Delete old items
      await txn.delete('receipt_items', where: 'receiptId = ?', whereArgs: [receipt.id]);

      // Save new items
      for (var item in receipt.items) {
        await txn.insert(
          'receipt_items',
          {
            'id': item.id,
            'receiptId': item.receiptId,
            'name': item.name,
            'quantity': item.quantity,
            'unitPrice': item.unitPrice,
            'lineTotal': item.lineTotal,
          },
        );
      }
    });
  }

  Future<Receipt?> getReceiptById(String id) async {
    final db = await database;
    final receiptMaps = await db.query(
      'receipts',
      where: 'id = ?',
      whereArgs: [id],
    );

    if (receiptMaps.isEmpty) return null;

    final receiptMap = receiptMaps.first;
    final items = await getReceiptItems(id);

    return _receiptFromMap(receiptMap, items);
  }

  Future<List<Receipt>> getAllReceipts() async {
    final db = await database;
    final receiptMaps = await db.query(
      'receipts',
      orderBy: 'createdAt DESC',
    );

    List<Receipt> receipts = [];
    for (var map in receiptMaps) {
      final items = await getReceiptItems(map['id'] as String);
      receipts.add(_receiptFromMap(map, items));
    }

    return receipts;
  }

  Future<List<Receipt>> getRecentReceipts(int limit) async {
    final db = await database;
    final receiptMaps = await db.query(
      'receipts',
      orderBy: 'createdAt DESC',
      limit: limit,
    );

    List<Receipt> receipts = [];
    for (var map in receiptMaps) {
      final items = await getReceiptItems(map['id'] as String);
      receipts.add(_receiptFromMap(map, items));
    }

    return receipts;
  }

  Future<List<Receipt>> searchReceipts({
    String? query,
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    final db = await database;
    String whereClause = '1=1';
    List<dynamic> whereArgs = [];

    if (startDate != null) {
      whereClause += ' AND date >= ?';
      whereArgs.add(startDate.toIso8601String());
    }

    if (endDate != null) {
      whereClause += ' AND date <= ?';
      whereArgs.add(endDate.toIso8601String());
    }

    final receiptMaps = await db.query(
      'receipts',
      where: whereClause,
      whereArgs: whereArgs,
      orderBy: 'createdAt DESC',
    );

    List<Receipt> receipts = [];
    for (var map in receiptMaps) {
      final items = await getReceiptItems(map['id'] as String);
      final receipt = _receiptFromMap(map, items);

      // Filter by query if provided
      if (query != null && query.trim().isNotEmpty) {
        final lowerQuery = query.toLowerCase();
        final matches = receipt.merchantName?.toLowerCase().contains(lowerQuery) == true ||
            receipt.note?.toLowerCase().contains(lowerQuery) == true ||
            receipt.items.any((item) => item.name.toLowerCase().contains(lowerQuery));
        if (matches) {
          receipts.add(receipt);
        }
      } else {
        receipts.add(receipt);
      }
    }

    return receipts;
  }

  Future<void> deleteReceipt(String id) async {
    final db = await database;
    await db.delete('receipts', where: 'id = ?', whereArgs: [id]);
    // Items will be deleted automatically due to CASCADE
  }

  // Receipt items operations
  Future<List<ReceiptItem>> getReceiptItems(String receiptId) async {
    final db = await database;
    final itemMaps = await db.query(
      'receipt_items',
      where: 'receiptId = ?',
      whereArgs: [receiptId],
    );

    return itemMaps.map((map) => _itemFromMap(map)).toList();
  }

  // Helper methods
  Receipt _receiptFromMap(Map<String, dynamic> map, List<ReceiptItem> items) {
    return Receipt(
      id: map['id'] as String,
      createdAt: DateTime.parse(map['createdAt'] as String),
      updatedAt: DateTime.parse(map['updatedAt'] as String),
      imageLocalPath: map['imageLocalPath'] as String,
      merchantName: map['merchantName'] as String?,
      date: DateTime.parse(map['date'] as String),
      subtotal: map['subtotal'] != null ? (map['subtotal'] as num).toDouble() : null,
      vatAmount: map['vatAmount'] != null ? (map['vatAmount'] as num).toDouble() : null,
      totalAmount: (map['totalAmount'] as num).toDouble(),
      currency: map['currency'] as String? ?? 'TRY',
      items: items,
      note: map['note'] as String?,
    );
  }

  ReceiptItem _itemFromMap(Map<String, dynamic> map) {
    return ReceiptItem(
      id: map['id'] as String,
      receiptId: map['receiptId'] as String,
      name: map['name'] as String,
      quantity: (map['quantity'] as num).toDouble(),
      unitPrice: (map['unitPrice'] as num).toDouble(),
      lineTotal: (map['lineTotal'] as num).toDouble(),
    );
  }

  Future<void> close() async {
    final db = await database;
    await db.close();
  }
}

