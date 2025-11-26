import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';
import '../models/receipt.dart';
import '../models/receipt_item.dart';
import '../services/database_service.dart';
import '../theme/app_theme.dart';
import 'receipt_detail_screen.dart';

class ReceiptEditScreen extends StatefulWidget {
  final String? receiptId;
  final String? imagePath;
  final ParsedReceipt? parsedReceipt;

  const ReceiptEditScreen({
    super.key,
    this.receiptId,
    this.imagePath,
    this.parsedReceipt,
  });

  @override
  State<ReceiptEditScreen> createState() => _ReceiptEditScreenState();
}

class _ReceiptEditScreenState extends State<ReceiptEditScreen> {
  final _formKey = GlobalKey<FormState>();
  final DatabaseService _dbService = DatabaseService();

  late TextEditingController _merchantNameController;
  late TextEditingController _dateController;
  late TextEditingController _totalAmountController;
  late TextEditingController _vatAmountController;

  DateTime _selectedDate = DateTime.now();
  List<ReceiptItem> _items = [];
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _merchantNameController = TextEditingController();
    _dateController = TextEditingController();
    _totalAmountController = TextEditingController();
    _vatAmountController = TextEditingController();

    if (widget.receiptId != null) {
      _loadReceipt();
    } else if (widget.parsedReceipt != null) {
      _loadParsedReceipt();
    } else {
      _dateController.text = DateFormat('yyyy-MM-dd').format(DateTime.now());
    }
  }

  Future<void> _loadReceipt() async {
    final receipt = await _dbService.getReceiptById(widget.receiptId!);
    if (receipt != null) {
      _merchantNameController.text = receipt.merchantName ?? '';
      _dateController.text = DateFormat('yyyy-MM-dd').format(receipt.date);
      _totalAmountController.text = receipt.totalAmount.toStringAsFixed(2);
      _vatAmountController.text = receipt.vatAmount?.toStringAsFixed(2) ?? '';
      _selectedDate = receipt.date;
      setState(() {
        _items = receipt.items;
      });
    }
  }

  void _loadParsedReceipt() {
    final parsed = widget.parsedReceipt!;
    _merchantNameController.text = parsed.merchantName ?? '';
    _dateController.text = DateFormat('yyyy-MM-dd').format(parsed.date);
    _totalAmountController.text = parsed.totalAmount.toStringAsFixed(2);
    _vatAmountController.text = parsed.vatAmount?.toStringAsFixed(2) ?? '';
    _selectedDate = parsed.date;
    setState(() {
      _items = parsed.items.map((item) {
        return ReceiptItem(
          id: const Uuid().v4(),
          receiptId: widget.receiptId ?? '',
          name: item.name,
          quantity: item.quantity,
          unitPrice: item.unitPrice,
          lineTotal: item.lineTotal,
        );
      }).toList();
    });
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
      locale: const Locale('tr', 'TR'),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        _dateController.text = DateFormat('yyyy-MM-dd').format(picked);
      });
    }
  }

  void _addItem() {
    setState(() {
      _items.add(ReceiptItem(
        id: const Uuid().v4(),
        receiptId: widget.receiptId ?? '',
        name: '',
        quantity: 1.0,
        unitPrice: 0.0,
        lineTotal: 0.0,
      ));
    });
  }

  void _updateItem(int index, String field, dynamic value) {
    setState(() {
      final item = _items[index];
      switch (field) {
        case 'name':
          _items[index] = item.copyWith(name: value as String);
          break;
        case 'quantity':
          final qty = double.tryParse(value.toString()) ?? 0.0;
          final lineTotal = qty * item.unitPrice;
          _items[index] = item.copyWith(quantity: qty, lineTotal: lineTotal);
          break;
        case 'unitPrice':
          final price = double.tryParse(value.toString()) ?? 0.0;
          final lineTotal = item.quantity * price;
          _items[index] = item.copyWith(unitPrice: price, lineTotal: lineTotal);
          break;
      }
    });
  }

  void _removeItem(int index) {
    setState(() {
      _items.removeAt(index);
    });
  }

  Future<void> _saveReceipt() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
    });

    try {
      final receiptId = widget.receiptId ?? const Uuid().v4();
      final now = DateTime.now();
      final existingReceipt = widget.receiptId != null
          ? await _dbService.getReceiptById(widget.receiptId!)
          : null;

      final receipt = Receipt(
        id: receiptId,
        createdAt: existingReceipt?.createdAt ?? now,
        updatedAt: now,
        imageLocalPath: widget.imagePath ?? existingReceipt!.imageLocalPath,
        merchantName: _merchantNameController.text.isEmpty
            ? null
            : _merchantNameController.text,
        date: _selectedDate,
        subtotal: null,
        vatAmount: _vatAmountController.text.isEmpty
            ? null
            : double.tryParse(_vatAmountController.text),
        totalAmount: double.parse(_totalAmountController.text),
        currency: 'TRY',
        items: _items.map((item) => item.copyWith(receiptId: receiptId)).toList(),
        note: null,
      );

      await _dbService.saveReceipt(receipt);

      if (!mounted) return;

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => ReceiptDetailScreen(receiptId: receiptId),
        ),
      );
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Kayıt hatası: ${e.toString()}'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  void dispose() {
    _merchantNameController.dispose();
    _dateController.dispose();
    _totalAmountController.dispose();
    _vatAmountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Fiş Detayı'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            // Basic Info Card
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFormField(
                      controller: _merchantNameController,
                      decoration: const InputDecoration(
                        labelText: 'İşletme Adı',
                        hintText: 'Örn: Migros',
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _dateController,
                      readOnly: true,
                      decoration: const InputDecoration(
                        labelText: 'Tarih *',
                        suffixIcon: Icon(Icons.calendar_today),
                      ),
                      onTap: () => _selectDate(context),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Tarih gereklidir';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _totalAmountController,
                      decoration: const InputDecoration(
                        labelText: 'Toplam Tutar *',
                        prefixText: '₺ ',
                      ),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Toplam tutar gereklidir';
                        }
                        final amount = double.tryParse(value);
                        if (amount == null || amount <= 0) {
                          return 'Geçerli bir tutar giriniz';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _vatAmountController,
                      decoration: const InputDecoration(
                        labelText: 'KDV',
                        prefixText: '₺ ',
                      ),
                      keyboardType: TextInputType.number,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Items Section
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Ürünler',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextButton.icon(
                  onPressed: _addItem,
                  icon: const Icon(Icons.add),
                  label: const Text('Yeni ürün ekle'),
                ),
              ],
            ),
            const SizedBox(height: 12),

            // Items List
            ...List.generate(_items.length, (index) {
              final item = _items[index];
              return Card(
                margin: const EdgeInsets.only(bottom: 12),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              initialValue: item.name,
                              decoration: const InputDecoration(
                                labelText: 'Ürün adı',
                                isDense: true,
                              ),
                              onChanged: (value) =>
                                  _updateItem(index, 'name', value),
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
                            onPressed: () => _removeItem(index),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              initialValue: item.quantity.toString(),
                              decoration: const InputDecoration(
                                labelText: 'Adet',
                                isDense: true,
                              ),
                              keyboardType: TextInputType.number,
                              onChanged: (value) =>
                                  _updateItem(index, 'quantity', value),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: TextFormField(
                              initialValue: item.unitPrice.toStringAsFixed(2),
                              decoration: const InputDecoration(
                                labelText: 'Birim Fiyat',
                                isDense: true,
                                prefixText: '₺ ',
                              ),
                              keyboardType: TextInputType.number,
                              onChanged: (value) =>
                                  _updateItem(index, 'unitPrice', value),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: TextFormField(
                              initialValue: item.lineTotal.toStringAsFixed(2),
                              decoration: const InputDecoration(
                                labelText: 'Ara Toplam',
                                isDense: true,
                                prefixText: '₺ ',
                              ),
                              readOnly: true,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            }),
            const SizedBox(height: 100), // Space for FAB
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _isLoading ? null : _saveReceipt,
        backgroundColor: AppTheme.primaryColor,
        label: _isLoading
            ? const SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              )
            : const Text('Kaydet'),
        icon: _isLoading ? null : const Icon(Icons.save),
      ),
    );
  }
}

